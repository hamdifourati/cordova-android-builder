# Build Cordova Application in Docker
---
> Build Cordova applications inside a docker container


## Docker repository
https://hub.docker.com/r/hamdifourati/cordova-android-builder/

## Requirements
- Docker

## Installed dependencies
- Ubuntu v16.04
- NodeJS v8.9.4
- Cordova v5.1.1
- Android SDK r24.2
- Android Platform Tools
- Android Build Tools 22.0.1
- Android 22

## How to
## Pull image from Docker hub

```
docker pull cordova-android-builder
```

### Build Dockerfile
```
docker build -t cordova-android-builder .
```

### Run Builder Container
```
docker run -it -v <local-app-src>:/src cordova-android-builder bash
```

## Build Cordova App
> Assuming you are inside the build container 

```
# Add android for cordova
cordova platform add android

# Compile Android APK
cordova prepare && cordova compile android
```

The Generated APK is in: `<cordova-ap-src-path>/platforms/android/build/outputs/apk/`

### Enjoy !
