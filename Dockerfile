# syntax=docker/dockerfile:1

FROM python:3.10-bullseye

ENV MPLCONFIGDIR=/tmp/matplotlib
ENV NUMBA_CACHE_DIR=/tmp/numba_cache
ENV HF_HOME=/app/cache/huggingface

RUN mkdir -p /app/matplotlib_cache /app/numba_cache && chmod -R 777 /app/matplotlib_cache /app/numba_cache
RUN mkdir -p /app/cache/huggingface && chmod -R 777 /app/cache/huggingface
RUN mkdir -p /app/rvc/configs/v1 && chmod -R 777 /app/rvc/configs

EXPOSE 6969

WORKDIR /app

RUN apt update && apt install -y -qq ffmpeg aria2 && apt clean

COPY . .

RUN pip3 install --no-cache-dir -r requirements.txt

VOLUME [ "/app/logs/weights", "/app/opt" ]

ENTRYPOINT [ "python3" ]

CMD ["app.py"]
