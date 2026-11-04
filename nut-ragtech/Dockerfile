FROM debian:bookworm-slim AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git autoconf automake libtool pkg-config gettext autopoint \
    bison flex python3 python3-dev \
    libssl-dev libusb-1.0-0-dev libsnmp-dev libneon27-dev \
    libwrap0-dev libsystemd-dev libavahi-client-dev \
    libipmimonitoring-dev libfreeipmi-dev libmodbus-dev \
    libpowerman0-dev libi2c-dev libgpiod-dev libcppunit-dev \
    libnss3-dev augeas-tools libaugeas-dev ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone --depth 1 https://github.com/networkupstools/nut.git
WORKDIR /opt/nut
ENV PYTHON=python3
RUN ./autogen.sh \
    && ./configure --prefix=/usr --sysconfdir=/etc/nut --with-ssl --with-usb --with-python=python3 \
    && make -j"$(nproc)" \
    && make install

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl3 libusb-1.0-0 libsnmp40 libneon27 libwrap0 jq ca-certificates python3 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/sbin/upsd /usr/sbin/upsd
COPY --from=build /usr/sbin/upsdrvctl /usr/sbin/upsdrvctl
COPY --from=build /usr/libexec/nut /usr/libexec/nut
COPY --from=build /usr/share/nut /usr/share/nut

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
