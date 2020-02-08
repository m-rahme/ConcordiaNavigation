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

echo "Fetching dependencies and building 'flutter_module'."
"${LOCAL_SDK_PATH}/bin/flutter" packages get
"${LOCAL_SDK_PATH}/bin/flutter" build aar

echo "Fetching dependencies for 'flutter_module_using_plugin'."
"${LOCAL_SDK_PATH}/bin/flutter" packages get

echo "== Testing Android Build =="

./gradlew --stacktrace assembleDebug
./gradlew --stacktrace assembleRelease

echo "-- Success --"
