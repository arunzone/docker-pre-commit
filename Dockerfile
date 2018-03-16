FROM ubuntu:16.04

#Install
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y python-software-properties build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y git-core curl

  # Install Java.
RUN mkdir -p Installs
ADD jdk-7u80-linux-x64.tar.gz Installs/
ADD jdk-8u161-linux-x64.tar.gz Installs/
RUN mkdir -p /usr/lib/jvm/ && mv /Installs/jdk1.8.0_161 /usr/lib/jvm/java-8-oracle
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /Installs/jdk1.7.0_80
ENV PATH=${JAVA_HOME}/bin:$PATH

#Install maven
ADD apache-maven-3.5.3-bin.tar.gz Installs/
ENV PATH=/Installs/apache-maven-3.5.3/bin:$PATH

# Node JS
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install --assume-yes nodejs
RUN npm install grunt-cli

RUN mkdir -p /root/.ssh
COPY id_rsa /root/.ssh/
COPY id_rsa.pub /root/.ssh/
RUN chmod 400 /root/.ssh/id_rsa
