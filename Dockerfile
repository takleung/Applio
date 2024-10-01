# syntax=docker/dockerfile:1

FROM python:3.10-bullseye

EXPOSE 6969

WORKDIR /app

RUN apt update && apt install -y -qq ffmpeg aria2 && apt clean

COPY . .

# Set the Hugging Face Transformers cache directory to a writable location
ENV TRANSFORMERS_CACHE=/app/cache/huggingface

# Create the cache directory
RUN mkdir -p /app/cache/huggingface && chmod -R 777 /app/cache/huggingface

RUN pip3 install --no-cache-dir -r requirements.txt

VOLUME [ "/app/logs/weights", "/app/opt" ]

ENTRYPOINT [ "python3" ]

CMD ["app.py"]
