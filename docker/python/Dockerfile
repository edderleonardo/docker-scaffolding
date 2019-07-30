FROM python:3.6
LABEL maintainer="Edder Ramirez <edderleonardo@gmail.com>"

# environment configuration
ENV PYTHONUNBUFFERED 1

# create app directory
WORKDIR /root

# install pip requirements
ADD requirements.txt /root/

# install gettext
RUN apt-get update
RUN apt-get install gettext -y

# install pip requirements
RUN pip install --upgrade pip
RUN pip install -r requirements.txt --default-timeout 450

# run code through volume
VOLUME /usr/src/app
WORKDIR /usr/src/app

# install postgres-client
RUN apt-get install -y postgresql-client

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# set display port to avoid crash
ENV DISPLAY=:99

EXPOSE 8000

CMD ["gunicorn", "-b", "0.0.0.0:8000", "newproject.wsgi:application", "--reload", "--enable-stdio-inheritance"]
