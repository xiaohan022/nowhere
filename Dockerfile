FROM python:3.12-slim

WORKDIR /app

# 全部源码（含 nowhere/data 数据文件）
COPY . .

# 安装依赖 + 安装 nowhere 包本身（读 pyproject.toml）
RUN pip install --no-cache-dir .

# 日志实时输出，方便排障
ENV PYTHONUNBUFFERED=1
# 持久化路径（需在 Zeabur 挂载卷到 /data）
ENV NOWHERE_HOME=/data

EXPOSE 8080

# 支持 Zeabur 的 PORT 注入，无 PORT 时回落到 8080
CMD ["sh", "-c", "python -m nowhere.server --web-only ${PORT:-8080}"]
