# Stage 1: Build Astro application
FROM node:22-alpine AS builder

LABEL org.opencontainers.image.source="https://github.com/idjiot-sandwiches/portfolio"
LABEL org.opencontainers.image.title="Portfolio"
LABEL org.opencontainers.image.description="Astro portfolio website"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.url="https://github.com/idjiot-sandwiches/portfolio"
LABEL org.opencontainers.image.vendor="Idjiot Sandwiches"

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build


# Stage 2: Production runtime
FROM node:22-alpine AS runtime

WORKDIR /app

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

ENV HOST=0.0.0.0
ENV PORT=4321

EXPOSE 4321

CMD ["node", "./dist/server/entry.mjs"]