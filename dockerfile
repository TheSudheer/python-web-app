FROM python:3.11-slim

WORKDIR /app

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

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    libffi-dev \
    python3-dev \
    default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

COPY . .
 
EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
