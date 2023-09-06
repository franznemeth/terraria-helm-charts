# TODO: pin version
FROM alpine
ARG S6_OVERLAY_VERSION=3.1.5.0

RUN apk add nginx unzip python3 python3-dev py3-pip py3-pillow py3-pillow-pyc zlib-dev jpeg-dev gcc musl-dev bash
ADD https://github.com/dhg/Skeleton/releases/download/2.0.4/Skeleton-2.0.4.zip /tmp
RUN rm -rf /var/lib/nginx/html/* && \
    unzip -d /tmp/ /tmp/Skeleton-2.0.4.zip && \
    mv /tmp/Skeleton-2.0.4/* /var/lib/nginx/html/ && \
    rm -rf /var/lib/nginx/html/index.html && \
    python3 -m pip install flyingsnake --upgrade && \
    rm -rf /tmp/Skeleton*
COPY zoom.css /var/lib/nginx/html/css/zoom.css
COPY zoom.js /var/lib/nginx/html/zoom.js

# s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

# scripts & s6 services
COPY flyingsnake.sh /flyingsnake.sh
RUN mkdir -p /etc/services.d/nginx /etc/services.d/flyingsnake
COPY flyingsnake.run /etc/services.d/flyingsnake/run
COPY nginx.run /etc/services.d/nginx/run
RUN chmod +x /etc/services.d/nginx/run /etc/services.d/flyingsnake/run

ENTRYPOINT ["/init"]
