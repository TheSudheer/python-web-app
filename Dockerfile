FROM python:3.11-alpine
WORKDIR /app
COPY requirements.txt /app/
COPY devops /app/
RUN apk add --no-cache gcc musl-dev python3-dev && \
    python3 -m venv venv1 && \
    source venv1/bin/activate && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del gcc musl-dev python3-dev
SHELL ["/bin/sh", "-c"]
EXPOSE 8000
CMD source venv1/bin/activate && python3 manage.py runserver 0.0.0.0:8000
