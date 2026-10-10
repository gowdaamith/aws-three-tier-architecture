resource "aws_security_group" "public_alb" {
  name = "${var.project_name}-${var.environment}-public-alb-sg"
  description = "sg for the public application load balancer"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-alb-sg"
    Tier        = "public-alb"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


resource "aws_vpc_security_group_ingress_rule" "public_alb_http" {
  security_group_id = aws_security_group.public_alb.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port=80
  to_port=80
  ip_protocol= "tcp"
}

resource "aws_vpc_security_group_egress_rule" "public_alb_all" {
  security_group_id = aws_security_group.public_alb.id
  description = "Allow outbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "web" {
  name = "${var.project_name}-${var.environment}-web-sg"
  description = "sg for the web server"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-web-sg"
    Tier        = "web"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


resource "aws_vpc_security_group_ingress_rule" "web_http" {
  security_group_id = aws_security_group.web.id
  referenced_security_group_id = aws_security_group.public_alb.id
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  description = "Allow HTTP from public ALB"
}


resource "aws_vpc_security_group_egress_rule" "web_all" {
  security_group_id = aws_security_group.web.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
  description = "Allow outbound traffic"
}

resource "aws_security_group" "app" {
  name        = "${var.project_name}-${var.environment}-app-sg"
  description = "Security group for application servers"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-app-sg"
    Tier        = "application"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_api" {
  security_group_id = aws_security_group.app.id

  referenced_security_group_id = aws_security_group.internal_alb.id

  from_port   = 5000
  to_port     = 5000
  ip_protocol = "tcp"
  description = "Allow API traffic from internal ALB"
}


resource "aws_vpc_security_group_egress_rule" "app_all" {
  security_group_id = aws_security_group.app.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
  description = "Allow outbound traffic"
}


resource "aws_security_group" "database" {
  name        = "${var.project_name}-${var.environment}-database-sg"
  description = "Security group for RDS database"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-database-sg"
    Tier        = "database"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "database_postgres" {
  security_group_id = aws_security_group.database.id

  referenced_security_group_id = aws_security_group.app.id

  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"
  description = "Allow PostgreSQL from application servers"
}


resource "aws_security_group" "internal_alb" {
  name        = "${var.project_name}-${var.environment}-internal-alb-sg"
  description = "Security group for internal application load balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-internal-alb-sg"
    Tier        = "internal-alb"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

}

resource "aws_vpc_security_group_ingress_rule" "internal_alb_http" {
  security_group_id = aws_security_group.internal_alb.id

  referenced_security_group_id = aws_security_group.web.id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  description = "Allow HTTP from web servers"
}

resource "aws_vpc_security_group_egress_rule" "internal_alb_all" {
  security_group_id = aws_security_group.internal_alb.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
  description = "Allow outbound traffic"
}
