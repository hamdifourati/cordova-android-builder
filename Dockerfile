#https://hub.docker.com/_/openjdk
ARG OPENJDK_VERSION=11
FROM openjdk:${OPENJDK_VERSION}

# Reference default value
ARG OPENJDK_VERSION
#https://github.com/nodesource/distributions/blob/master/README.md
ARG NODEJS_VERSION=19
#https://gradle.org/releases/
ARG GRADLE_VERSION=7.4.2
#https://www.npmjs.com/package/cordova?activeTab=versions
ARG CORDOVA_VERSION=11.0.0
#https://developer.android.com/studio#command-tools
ARG ANDROID_CMDTOOLS_VERSION=9477386


LABEL maintainer="Hamdi Fourati <contact@hamdifourati.info>"

WORKDIR /opt/src

ENV JAVA_HOME /usr/local/openjdk-${OPENJDK_VERSION}/
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV GRADLE_USER_HOME /opt/gradle
ENV PATH $PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$GRADLE_USER_HOME/bin

# NodeJS
RUN echo https://deb.nodesource.com/setup_${NODEJS_VERSION}.x
RUN curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash -
RUN apt -qq install -y nodejs

# Cordova
RUN npm i -g cordova@${CORDOVA_VERSION}

# Gradle
RUN curl -so /tmp/gradle-${GRADLE_VERSION}-bin.zip https://downloads.gradle-dn.com/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip -qd /opt /tmp/gradle-${GRADLE_VERSION}-bin.zip && \
    ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle

# Android
RUN curl -so /tmp/commandlinetools-linux-${ANDROID_CMDTOOLS_VERSION}_latest.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_CMDTOOLS_VERSION}_latest.zip && \
    mkdir -p $ANDROID_HOME/cmdline-tools/ && \
    unzip -qd $ANDROID_HOME/cmdline-tools/ /tmp/commandlinetools-linux-${ANDROID_CMDTOOLS_VERSION}_latest.zip && \
    mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest


# Update and accept licences
COPY android.packages android.packages
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | sdkmanager --package_file=android.packages
