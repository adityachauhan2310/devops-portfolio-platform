# 1. Start from a small, official Python image (same Python version as your laptop)
FROM python:3.12-slim

# 2. Recommended Python settings inside containers
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 3. Work inside the /app folder in the container
WORKDIR /app

# 4. Install packages FIRST (explained below: "layers")
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Then copy our app code
COPY app ./app

# 6. Create a normal user and switch to it (never
RUN useradd --create-home --uid 10001 appuser
USER appuser

# 7. Note: the app listens on port 8000
EXPOSE 8000

# 8. Health check: Docker asks /health every 30 se
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000/health', timeout=2)" || exit 1

# 9. The command that starts the app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]