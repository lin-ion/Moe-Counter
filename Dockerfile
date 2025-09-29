FROM node:22-alpine

RUN corepack enable && corepack prepare pnpm@10.11.0 --activate

COPY . /app
WORKDIR /app

COPY package.json ./
COPY pnpm-lock.yaml ./

RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store pnpm fetch --frozen-lockfile
RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store pnpm install --frozen-lockfile

EXPOSE 3000

CMD ["pnpm", "start"]
