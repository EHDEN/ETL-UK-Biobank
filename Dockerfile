FROM python:slim

WORKDIR /app

ADD requirements.txt /app
RUN pip install --no-cache-dir -r /app/requirements.txt

COPY . .
