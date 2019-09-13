#!/bin/bash

# Originally written by Ralf Kistner <ralf@embarkmobile.com>, but placed in the public domain

$ANDROID_HOME/emulator/emulator @notifybest -verbose -no-snapshot -no-window -no-audio

/android-wait-for-emulator