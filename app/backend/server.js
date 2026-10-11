const express = require("express");
const { Pool } = require("pg");

const app = express();
const port = 5000;

app.use(express.json());

const pool = new Pool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 5432),
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: process.env.DB_SSL === "true"
    ? { rejectUnauthorized: true }
    : false,
  connectionTimeoutMillis: 5000
});

// Check whether the API can reach PostgreSQL.
app.get("/health", async (req, res) => {
  try {
    await pool.query("SELECT 1");
    res.status(200).json({
      status: "healthy",
      database: "connected"
    });
  } catch (error) {
    console.error("Database health check failed:", error.message);
    res.status(503).json({
      status: "unhealthy",
      database: "unavailable"
    });
  }
});

app.get("/live", (req, res) => {
  res.status(200).json({
    status: "alive"
  });
});

// Retrieve students from PostgreSQL.
app.get("/api/students", async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT id, name, email FROM students ORDER BY id"
    );

    res.status(200).json(result.rows);
  } catch (error) {
    console.error("Failed to retrieve students:", error.message);
    res.status(500).json({
      error: "Unable to retrieve students"
    });
  }
});

app.listen(port, "0.0.0.0", () => {
  console.log(`Student API listening on port ${port}`);
});
