FROM openjdk:8

LABEL maintainer="Hamdi Fourati <contact@hamdifourati.info>"

WORKDIR /opt/src

ENV JAVA_HOME /usr/local/openjdk-8/
ENV ANDROID_SDK_ROOT /usr/local/android-sdk-linux
ENV GRADLE_USER_HOME /opt/gradle
ENV PATH $PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$GRADLE_USER_HOME/bin

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt -qq install -y nodejs

# Cordova
RUN npm i -g cordova@10.0.0

# Gradle
RUN curl -so /tmp/gradle-6.8.2-bin.zip https://downloads.gradle-dn.com/distributions/gradle-6.8.2-bin.zip && \
    unzip -qd /opt /tmp/gradle-6.8.2-bin.zip && \
    ln -s /opt/gradle-6.8.2 /opt/gradle

# Android
RUN curl -so /tmp/commandlinetools-linux-6858069_latest.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip && \
    mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/ && \
    unzip -qd $ANDROID_SDK_ROOT/cmdline-tools/ /tmp/commandlinetools-linux-6858069_latest.zip && \
    mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest


# Update and accept licences
COPY android.packages android.packages
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | sdkmanager --package_file=android.packages
