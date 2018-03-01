# Build Cordova Application in Docker
---
> Build Cordova applications inside a docker container

> TODO: Upload docker image to docker hub and provide instructions to pull it and use.

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
