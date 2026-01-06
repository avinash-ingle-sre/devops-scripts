FROM ubuntu:16.04
USER root

RUN apt-get update && apt-get install -y curl

COPY secrets.key /app/
COPY database.pem /app/

WORKDIR /app
CMD ["python", "app.py"]
