#!/bin/sh
#
# Copyright 2019 - The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# First we place the adb secret in the right place if it exists
mkdir -p /root/.android

if [ -f "/run/secrets/adbkey" ]; then
    echo "Copying key from secret partition"
    cp /run/secrets/adbkey /root/.android
    chmod 600 /root/.android/adbkey
elif [ ! -z "${ADBKEY}" ]; then
    echo "Using provided secret"
    echo "-----BEGIN PRIVATE KEY-----" > /root/.android/adbkey
    echo $ADBKEY | tr " " "\n" | sed -n "4,29p" >> /root/.android/adbkey
    echo "-----END PRIVATE KEY-----" >> /root/.android/adbkey
    chmod 600 /root/.android/adbkey
else
    echo "No adb key provided.. You might not be able to connect to the emulator."
fi

# We need pulse audio for the webrtc video bridge
pulseaudio -D

# All our ports are loopback devices, so setup a simple forwarder
socat -d tcp-listen:5555,reuseaddr,fork tcp:127.0.0.1:6555 &

# Kick off the emulator
exec emulator/emulator @Pixel2 -verbose -show-kernel -ports 6554,6555 -grpc 5556 -no-window -gpu swiftshader_indirect -skip-adb-auth -logcat "*:v"
