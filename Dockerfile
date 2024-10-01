# syntax=docker/dockerfile:1

FROM python:3.10-bullseye

EXPOSE 6969

WORKDIR /app

RUN apt update && apt install -y -qq ffmpeg aria2 && apt clean

COPY . .

RUN pip3 install --no-cache-dir -r requirements.txt

# OpenShift runs containers as non-root by default, so we should ensure directory permissions are set accordingly
RUN chown -R 1001:0 /app && chmod -R g+rwX /app

USER 1001

VOLUME [ "/app/logs/weights", "/app/opt" ]

ENTRYPOINT [ "python3" ]

CMD ["app.py"]
