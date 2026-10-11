
FROM node:22-bookworm-slim

ENV NODE_ENV=production

WORKDIR /app

COPY package.json ./

RUN npm install  --omit=dev \
    && npm cache clean --force

COPY --chown=node:node server.js ./

USER node

EXPOSE 5000

CMD ["node", "server.js"]

