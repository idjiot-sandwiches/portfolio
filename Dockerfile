FROM node:lts AS runtime

LABEL org.opencontainers.image.source="https://github.com/idjiot-sandwiches/portfolio.git"
LABEL org.opencontainers.image.title="Portfolio"
LABEL org.opencontainers.image.description="Portfolio image"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.url="https://github.com/idjiot-sandwiches/portfolio.git"
LABEL org.opencontainers.image.vendor="Idjiot Sandwiches"

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

ENV HOST=0.0.0.0
ENV PORT=4321
EXPOSE 4321
CMD ["node", "./dist/server/entry.mjs"]