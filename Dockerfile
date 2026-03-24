# Stage 1
FROM python:3.9-slim as builder

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends gcc g++

COPY app/requirements.txt .

RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt


# Stage 2
FROM python:3.9-slim

# Создаем непривилегированного пользователя
RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser

WORKDIR /app

# Копируем собранные библиотеки из Stage 1
COPY --from=builder /app/wheels /wheels
COPY app/requirements.txt .
RUN pip install --no-cache /wheels/*

# Копируем код приложения
COPY app/ /app/

# Меняем владельца папки
RUN chown -R appuser:appuser /app

# Переключаемся на appuser
USER appuser

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]