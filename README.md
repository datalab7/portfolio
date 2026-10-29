# Portfólio — dev local → stage → produção

```
Mac (VS Code + Docker)  →  git push  →  GitHub
                                          ├─ branch develop → STAGE (Railway)
                                          └─ branch main    → PRODUÇÃO (Railway)
```

A plataforma (Railway) lê o `Dockerfile` do repositório, constrói a imagem e
publica com HTTPS. Cada ambiente fica ligado a uma branch: deu push, deployou.

## Fase 1 — Dev local

1. Abra a pasta no VS Code.
2. Suba o app:
   ```bash
   docker compose up --build
   ```
3. Acesse http://localhost:8000 e http://localhost:8000/health
4. Edite `app/main.py` e salve: o app recarrega sozinho.

## Fase 2 — GitHub

```bash
git init
git add .
git commit -m "primeiro commit"
git branch -M main
git remote add origin git@github.com:SEU_USUARIO/portfolio.git
git push -u origin main
git checkout -b develop
git push -u origin develop
```

## Fase 3 — Railway (stage e produção)

1. Crie a conta em railway.com com o login do GitHub e assine o plano Hobby.
2. **New Project → Deploy from GitHub repo** → escolha `portfolio`.
3. No serviço: **Settings → Root Directory = `/app`** (onde está o Dockerfile).
4. Ambiente `production`: branch **main**; variável `APP_ENV=prod`.
5. Crie o ambiente `staging` (duplicando o production): branch **develop**;
   variável `APP_ENV=stage`.
6. Em cada ambiente: **Networking → Generate Domain** para ter a URL pública.

## Fluxo de trabalho do dia a dia

1. Desenvolve e testa local (`docker compose up`).
2. `git push` na **develop** → atualiza o **stage** → você confere.
3. Pull Request `develop → main` no GitHub → merge → atualiza a **produção**.

## Próximos passos

- Domínio próprio apontando para a produção.
- Testes automáticos no GitHub Actions bloqueando merge se falharem.
- Cada novo app do portfólio vira um serviço novo no mesmo projeto.
