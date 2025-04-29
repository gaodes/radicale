FROM tomsquest/docker-radicale:3.5.2.0

ARG COMMIT_ID
ENV COMMIT_ID=${COMMIT_ID}

ARG BUILD_UID
ENV BUILD_UID=${BUILD_UID:-1000}

ARG BUILD_GID
ENV BUILD_GID=${BUILD_GID:-1000}

LABEL maintainer="El Che <elche@elches.cloud>" \
      org.label-schema.name="Radicale Docker Image with birthday script" \
      org.label-schema.description="Enhanced Docker image for Radicale, the CalDAV/CardDAV server with capabilities to generate birthday calendar from the address books" \
      org.label-schema.url="https://github.com/gaodes/radicale" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$COMMIT_ID \
      org.label-schema.vcs-url="https://github.com/tomsquest/docker-radicale" \
      org.label-schema.schema-version="1.0"

RUN apk add --no-cache \
        py3-dateutil \
        py3-vobject \
        py3-pip \
    && rm -fr /root/.cache

RUN curl -o /usr/local/bin/create_birthday_calendar.py https://raw.githubusercontent.com/iBigQ/radicale-birthday-calendar/535ae54ef6464b1aba825af794ecc4c4dbf3d3c3/create_birthday_calendar.py && \
    chmod +x /usr/local/bin/create_birthday_calendar.py