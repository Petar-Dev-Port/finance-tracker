# Finance Tracker

Go API + React SPA, deployed via GitOps (ArgoCD) into the `finance` namespace.
Go binary serves the built React app (single container).

## Structure
- `app/` — Go backend (API)
- `frontend/` — React SPA
- `deploy/` — Kubernetes manifests + ArgoCD (ops)
- `.github/` — CI/CD (ops)

## Getting started (dev)

Start the local database:

docker compose up -d

Initialize the backend (run once, from repo root):

cd app && go mod init github.com/Petar-Dev-Port/finance-tracker/app

Initialize the frontend (run once, from repo root):

npm create vite@latest frontend -- --template react

Backend must follow the rules in `CONTRACT.md` (PORT, /healthz, /readyz, /metrics, env-only config).