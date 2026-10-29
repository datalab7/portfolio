import os

from fastapi import FastAPI
from fastapi.responses import HTMLResponse

APP_ENV = os.getenv("APP_ENV", "dev")
APP_VERSION = os.getenv("APP_VERSION", "local")

app = FastAPI(title="Portfolio")


@app.get("/", response_class=HTMLResponse)
def home():
    return f"""
    <html>
      <head><title>Portfolio ({APP_ENV})</title></head>
      <body style="font-family: sans-serif; max-width: 640px; margin: 40px auto;">
        <h1>Meu portfólio</h1>
        <p>Ambiente: <strong>{APP_ENV}</strong> · versão: <code>{APP_VERSION}</code></p>
        <ul>
          <li>App 1 — em breve</li>
          <li>App 2 — em breve</li>
        </ul>
      </body>
    </html>
    """


@app.get("/health")
def health():
    return {"status": "ok", "env": APP_ENV, "version": APP_VERSION}
