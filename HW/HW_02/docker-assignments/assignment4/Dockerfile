# Stage 1: Build environment
FROM python:3.9-slim AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install --prefix=/install -r requirements.txt

# Stage 2: Runtime environment
FROM python:3.9-slim
WORKDIR /app
COPY --from=build /install /usr/local
COPY app.py .
CMD ["python", "app.py"]
