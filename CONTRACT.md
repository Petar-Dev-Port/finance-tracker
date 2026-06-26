# Dev / Ops Contract

Rules the app must obey so deployment never breaks on app code, and vice versa.

1. **Config from environment variables only** — DB URL, port, secrets. No committed `.env`.
2. **Listen on `PORT`** (default `8080`).
3. **Expose `/healthz`** (liveness) and **`/readyz`** (readiness) returning HTTP 200.
4. **Stateless** — all state in Postgres. Nothing written to local disk.
5. **DB migrations are a separate step**, not run inside `main()`.
6. **Expose `/metrics`** in Prometheus format (the monitoring stack scrapes it).

## Territory split
- `app/` — Go backend. **Dev's territory.**
- `frontend/` — React SPA. **Dev's territory.**
- `deploy/`, `.github/`, `Dockerfile` — infra/CI. **Petar's territory.**

## Local dev — DB connection
`docker compose up -d` starts Postgres on `localhost:5432`:
`DATABASE_URL=postgres://finance:finance@localhost:5432/finance?sslmode=disable`