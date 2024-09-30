# Base image with Python
FROM python:3.10-slim

# Set environment variables for Matplotlib and Numba
ENV MPLCONFIGDIR=/tmp/matplotlib
ENV NUMBA_CACHE_DIR=/tmp/numba_cache

# Create the directories for the environment variables
RUN mkdir -p /tmp/matplotlib /tmp/numba_cache

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file to the container
COPY requirements.txt .

# Upgrade pip and install the required Python packages
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code to the container
COPY . .

# Expose the port if your app runs on a specific port (e.g., 8080)
# EXPOSE 8080

# Set the default command to run your application
CMD ["python3", "app.py"]
