FROM python:3.11-slim
 
# Use an official Python runtime image as the base image
FROM python:3.11-slim

# Set environment variables for application configuration
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    SECRET_KEY="your-secret-key" \
    DB_HOST="localhost" \
    DB_PORT=5432 \
    API_ENDPOINT="https://api.example.com" \
    LOG_LEVEL="INFO" \
    APP_MODE="production" \
    CACHE_TIMEOUT=300 \
    MAX_CONNECTIONS=100

# Set the working directory in the container
WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    libffi-dev \
    python3-dev \
    default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies (add your requirements file)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Expose the port the app runs on (if applicable)
EXPOSE 8000

# Define the command to run the application
CMD ["python", "app.py"] 

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

COPY . .
 

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
