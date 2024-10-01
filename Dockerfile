# syntax=docker/dockerfile:1

# Use the base image with Python
FROM python:3.10-bullseye

# Set environment variables
ENV MPLCONFIGDIR=/tmp/matplotlib
ENV NUMBA_CACHE_DIR=/tmp/numba_cache
ENV HF_HOME=/app/cache/huggingface

# Create necessary directories
RUN mkdir -p /app/matplotlib_cache /app/numba_cache /app/cache/huggingface /app/rvc/configs/v1

# Create a non-root user and group
RUN groupadd -g 1001 appgroup && useradd -m -u 1001 -g appgroup appuser

# Set the working directory
WORKDIR /app

# Install necessary packages as root
RUN apt update && apt install -y -qq ffmpeg aria2 && apt clean

# Copy the application code into the container
COPY . .

# Change ownership of all files to appuser and set permissions to 755
RUN chown -R appuser:appgroup /app && chmod -R 755 /app

# Switch to the non-root user
USER appuser

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose the necessary port
EXPOSE 6969

# Define the volumes
VOLUME [ "/app/logs/weights", "/app/opt" ]

# Set the default command to run your application
ENTRYPOINT [ "python3" ]
CMD ["app.py"]
