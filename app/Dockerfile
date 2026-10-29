FROM python:3.12-slim

WORKDIR /app

# Dependências primeiro: aproveita o cache do Docker quando só o código muda
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Não rodar como root dentro do container
RUN useradd --create-home appuser
USER appuser

# A plataforma na nuvem define a variável PORT; localmente usa 8000
ENV PORT=8000
EXPOSE 8000
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT}"]
