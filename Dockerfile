FROM python:3.12-slim

WORKDIR /app

# all source (incl. nowhere/data)
COPY . .

# install deps + the nowhere package itself (reads pyproject.toml)
RUN pip install --no-cache-dir .

ENV PYTHONUNBUFFERED=1
ENV NOWHERE_HOME=/data

EXPOSE 8080

# app.py serves REST + MCP over HTTP on the same port
CMD ["sh", "-c", "python app.py"]
