#!/bin/bash

set -e

# Backs up one directory at a time, looking for one called "flutter". Once it
# finds that directory, an absolute path to it is returned.
function getFlutterPath() {
    local path=""
    local counter=0

    while [[ "${counter}" -lt 10 ]]; do
        [ -d "${path}flutter" ] && echo "$(pwd)/${path}flutter" && return 0
        let counter++
        path="${path}../"
    done
}

readonly LOCAL_SDK_PATH=$(getFlutterPath)

if [ -z "${LOCAL_SDK_PATH}" ]
then
    echo "Failed to find the Flutter SDK!"
    exit 1
fi

echo "Flutter SDK found at ${LOCAL_SDK_PATH}"

echo "Pre-caching ios artifacts, such as the Flutter.framework"
"${LOCAL_SDK_PATH}/bin/flutter" precache --no-web --no-linux --no-windows --no-fuchsia --no-android --no-macos

echo "Fetching dependencies and building 'flutter_module'."
"${LOCAL_SDK_PATH}/bin/flutter" packages get
"${LOCAL_SDK_PATH}/bin/flutter" build ios-framework

echo "== Testing iOS build =="
pod install

xcodebuild -workspace "ios.xcworkspace" \
-scheme "IOSFullScreen" CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO \
CODE_SIGN_IDENTITY=- EXPANDED_CODE_SIGN_IDENTITY=- \
COMPILER_INDEX_STORE_ENABLE=NO CONFIGURATION=Debug | xcpretty


echo "-- Success --"
