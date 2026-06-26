# syntax=docker/dockerfile:1

# ── Stage 1: build the React frontend ──────────────────────────────
FROM node:20-alpine AS frontend
WORKDIR /frontend
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
RUN npm run build
# Vite outputs to /frontend/dist

# ── Stage 2: build the Go binary ───────────────────────────────────
FROM golang:1.23-alpine AS backend
WORKDIR /app
COPY app/go.mod app/go.sum* ./
RUN go mod download
COPY app/ ./
# Static build so it runs in distroless
RUN CGO_ENABLED=0 GOOS=linux go build -o /server ./cmd/server

# ── Stage 3: minimal runtime ───────────────────────────────────────
FROM gcr.io/distroless/static-debian12:nonroot
WORKDIR /
COPY --from=backend /server /server
# React build served from /web (Go serves static files from here)
COPY --from=frontend /frontend/dist /web
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/server"]