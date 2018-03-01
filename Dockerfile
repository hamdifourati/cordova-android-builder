FROM ubuntu:16.04
# Install Java.

RUN apt-get -qq update && \
  apt-get -qq install -y software-properties-common python-software-properties
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get -qq update && \
  apt-get -qq install -y curl oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get -qq install -y nodejs

# install cordova
RUN npm i -g cordova@5.1.1

# Install Android
RUN \
  apt-get -qq install -y lib32stdc++6 lib32z1

# download and extract android sdk
ADD http://dl.google.com/android/android-sdk_r24.2-linux.tgz /usr/local/
RUN tar xavf /usr/local/android-sdk_r24.2-linux.tgz -C /usr/local/ && \
  rm  /usr/local/android-sdk_r24.2-linux.tgz
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# update and accept licences
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /usr/local/android-sdk-linux/tools/android update sdk --no-ui -a --filter platform-tool,build-tools-22.0.1,android-22;
RUN find /usr/local/android-sdk-linux -perm 0744 | xargs chmod 755

ENV GRADLE_USER_HOME /src/gradle
# Run this fo rhello-world app
#RUN  cd /usr/lib/node_modules/cordova/node_modules/cordova-lib/ && npm install && cd -
WORKDIR /src
