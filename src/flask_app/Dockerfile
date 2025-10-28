# Use a lightweight official Python base image
FROM python:3.11-slim

WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code into the container
COPY app.py .

# Expose port Flask will run on
EXPOSE 5000
# Set environment variable for Flask if needed
#ENV FLASK_APP=app.py
# Start the app
CMD ["python", "app.py"]