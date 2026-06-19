FROM python:3.12-slim 
# get latest python image, slim is smaller

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
# PYTHONDONTWRITEBYTECODE prevents Python from writing .pyc files, which can help reduce the size of the Docker image and improve performance. 
# PYTHONUNBUFFERED ensures that Python output is sent directly to the terminal without buffering, which can be useful for debugging and logging in a Docker container.

WORKDIR /app
# same as mkdir /app && cd /app

ARG UID=10001
# set UID variable

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
# linux command to create a user that is un-loginable.

COPY requirements.txt .
# get requirements.txt file into the container
RUN pip install --no-cache-dir -r requirements.txt 
# The --no-cache-dir option prevents pip from caching the downloaded packages, which can help reduce the size of the Docker image.

USER appuser
# switch to the user

COPY . .
# copy the rest of the files. It is done after switching to the user to avoid permission issues when running the container.
# plus any changes in the code will not require re-installing the dependencies

EXPOSE 5000
# expose the port on the container

CMD ["python", "app.py"]
# start the app when container runs.