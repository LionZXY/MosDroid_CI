#Роботоспособность не гарантированна

FROM jangrewe/gitlab-ci-android:latest

RUN apt-get update -y && apt-get install wget -y

RUN echo no | $ANDROID_HOME/tools/bin/avdmanager create \
    avd -n notifybest -k "system-images;android-28;google_apis;x86"

COPY run-emulator.sh /run-emulator.sh
COPY android-wait-for-emulator.sh /android-wait-for-emulator.sh

RUN chmod +x run-emulator.sh
RUN chmod +x android-wait-for-emulator.sh