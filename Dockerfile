FROM python:3.9

# Set working directory where manage.py is located
WORKDIR /app

# Copy dependency files first for caching
COPY requirements.txt /app

# Install system dependencies & Python dependencies
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Now copy all app code
COPY . /app

# Expose Django port
EXPOSE 8000

# Start Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
