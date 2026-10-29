#!/usr/bin/env bash
# Simula uma plataforma de deploy: constrói a partir do GitHub e roda o container.
# Uso: ./scripts/deploy-local.sh stage   |   ./scripts/deploy-local.sh prod
set -euo pipefail

ENV=${1:?uso: ./scripts/deploy-local.sh stage|prod}
case "$ENV" in
  stage) BRANCH=develop; PORT=8001 ;;
  prod)  BRANCH=main;    PORT=8002 ;;
  *) echo "Ambiente inválido: use stage ou prod"; exit 1 ;;
esac

REPO=https://github.com/datalab7/portfolio.git
SHA=$(git ls-remote "$REPO" "refs/heads/$BRANCH" | cut -c1-7)
IMAGE="portfolio:$ENV-$SHA"

echo "==> Build de $BRANCH ($SHA) a partir do GitHub"
docker build -t "$IMAGE" "$REPO#$BRANCH:app"

echo "==> Substituindo o container portfolio-$ENV"
docker rm -f "portfolio-$ENV" >/dev/null 2>&1 || true
docker run -d --name "portfolio-$ENV" --restart unless-stopped \
  -p "$PORT:8000" \
  -e APP_ENV="$ENV" -e APP_VERSION="$SHA" \
  "$IMAGE"

echo "==> $ENV no ar: http://localhost:$PORT (versão $SHA)"
