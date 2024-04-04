FROM python:3.8-slim-bookworm

USER root

WORKDIR /src

COPY ./requirements.txt requirements.txt

# Dependencies required for psycopg2 (used for Postgres client)
RUN apt update -y && apt install -y build-essential libpq-dev
RUN pip install --upgrade pip setuptools wheel

# Dependencies are installed during build time in the container itself so we don't have OS mismatch
RUN pip install -r requirements.txt

COPY . .

# environment variables used by config.py
ENV DB_USERNAME=myuser
ENV DB_PASSWORD=mypassword

# This does not work, can't find localhost
# ENV DB_HOST=localhost

# Not working Found this by running `ip addr show docker0`
ENV DB_HOST=172.17.0.1

# Not working Found this by running `ip addr show eth0`
# ENV DB_HOST=10.124.22.71

# ENV DB_PORT=5433
ENV DB_PORT=5440
ENV DB_NAME=mydatabase

CMD python app.py
