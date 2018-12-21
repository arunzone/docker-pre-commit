FROM ubuntu:18.04

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=192 \
    JAVA_BUILD=12 \
    JAVA_PATH=750e1c8617c5452694857ad95c3ee230 \
    JAVA_HOME="/usr/lib/jvm/default-jvm"

#Install
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y software-properties-common build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y git-core curl wget ca-certificates

RUN cd "/tmp" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    ls -al && \
    sudo mv /usr/lib/jvm/default-jvm
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/default-jvm
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
COPY config /root/.ssh/
RUN chmod 400 /root/.ssh/id_rsa
RUN chmod 400 /root/.ssh/id_rsa.pub

RUN apt-get install -y libfontconfig time
