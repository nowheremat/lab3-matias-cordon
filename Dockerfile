FROM node:22-alpine

RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY nest-cli.json tsconfig.json tsconfig.build.json ./
COPY src/ ./src/
COPY node_modules/ ./node_modules/

RUN pnpm run build && pnpm prune --prod

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENV PORT=3000
ENV AMBIENTE=desarrollo
ENV API_KEY=changeme
ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "dist/main"]