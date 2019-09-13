
FROM debian:stretch-slim
LABEL maintainer="nikita@kulikof.ru" \
      com.google.android.emulator.build-date="TEST_DATE" \
      com.google.android.emulator.description="Pixel 2 Emulator, running API TEST_API" \
      com.google.android.emulator.version="IMAGE_TEST_TAG-TEST_API-TEST_ABI/TEST_BUILD_ID"

# Workaround for https://github.com/debuerreotype/docker-debian-artifacts/issues/24
RUN mkdir -p /usr/share/man/man1

# Install all the required emulator dependencies.
# You can get these by running ./android/scripts/unix/run_tests.sh --verbose --verbose --debs | grep apt | sort -u
# pulse audio is needed due to some webrtc dependencies.
RUN apt-get update -qq && apt-get install -y -qq \
# Needed for install / debug
    curl unzip procps bash wget default-jre \
# Emulator & video bridge dependencies
    libc6 libdbus-1-3 libfontconfig1 libgcc1 \
    libpulse0 libtinfo5 libx11-6 libxcb1 libxdamage1 \
    libxext6 libxfixes3 zlib1g libgl1 pulseaudio socat

# Next we get an android image ready
# We explicitly curl the image from a public site to make sure we
# don't accidentally publish internal testing images.
# Now we configure the user account under which we will be running the emulator
RUN mkdir -p /android/sdk/platforms && \
    mkdir -p /android/sdk/platform-tools && \
    mkdir -p /android/sdk/system-images && \
    mkdir -p /android-home

RUN wget -q -P /android/sdk/ https://dl.google.com/android/repository/sys-img/android/x86_64-29_r05.zip
RUN wget -q -P /android/sdk/ https://dl.google.com/android/repository/emulator-linux-5645604.zip
COPY launch-emulator.sh /android/sdk/
COPY default.pa /android/sdk/
COPY platform-tools /android/sdk/
COPY avd /android-home
COPY default.pa /etc/pulse/default.pa

RUN unzip -u -o /android/sdk/emulator-linux-5645604.zip -d /android/sdk/ && \
    unzip -u -o /android/sdk/x86_64-29_r05.zip -d /android/sdk/system-images/android && \
    gpasswd -a root audio && \
    chmod +x /android/sdk/launch-emulator.sh

# Create an initial snapshot so we will boot fast next time around.
# Doesn't work due to not being able run privileged container
# see: https://github.com/moby/moby/issues/1916
# RUN cd /android/sdk && emulator/emulator @Pixel2 -verbose -quit-after-boot 300

# Open up adb & grpc port
EXPOSE 5555
EXPOSE 5556
ENV ANDROID_SDK_ROOT /android/sdk
ENV ANDROID_AVD_HOME /android-home
ENV ANDROID_HOME /android/sdk
ENV PATH="$ANDROID_HOME/adb:${PATH}"
ENV PATH="$ANDROID_HOME/platform-tools:${PATH}"
WORKDIR /android/sdk
