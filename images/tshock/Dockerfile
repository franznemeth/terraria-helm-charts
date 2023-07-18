#  The MIT License (MIT)
#
#  Copyright (c) Seppe Volkaerts <https://seppevolkaerts.be>
#  Copyright (c) 2015 Ryan Sheehan
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE.

FROM mcr.microsoft.com/dotnet/runtime:6.0

LABEL maintainer="Franz Nemeth <franz.nemeth@fnemeth.net>"

#RUN apk add --update-cache unzip aspnetcore6-runtime dotnet6-sdk pcre-tools
RUN apt update && apt install -y unzip pcregrep && rm -rf /var/lib/apt/lists*


ENV TSHOCK_VERSION=v5.2.0
ENV TSHOCK_ZIP=TShock-5.2-for-Terraria-1.4.4.9-linux-x64-Release.zip

# Download and unpack TShock
ADD https://github.com/Pryaxis/TShock/releases/download/$TSHOCK_VERSION/$TSHOCK_ZIP /
RUN unzip $TSHOCK_ZIP -d /tshock && \
    tar xfva /tshock/TShock-Beta-linux-x64-Release.tar -C /tshock/ && \
    rm $TSHOCK_ZIP && \
    chmod +x /tshock/TShock.Server && \
    groupadd terraria -g 1000 && \
    useradd terraria -m -u 1000 -g 1000 && \
    chown terraria:terraria /tshock && \
    mkdir /tshock/tmp

# Server port
EXPOSE 7777

# Rest API port
EXPOSE 7878

COPY bootstrap.sh /tshock

WORKDIR /home/terraria/server


VOLUME [ "/home/terraria/server/worlds"  ]
VOLUME [ "/home/terraria/server/logs"    ]
VOLUME [ "/home/terraria/server/plugins" ]
VOLUME [ "/home/terraria/server/config"  ]
VOLUME [ "/home/terraria/server/tshock"  ]

RUN mkdir -p worlds && \
  mkdir -p logs && \
  mkdir -p config && \
  mkdir -p plugins && \
  mkdir -p tshock

RUN chown -R terraria:terraria /home/terraria/server && \
    chown -R terraria:terraria /tshock

USER terraria

ENTRYPOINT [ "/bin/sh", "/tshock/bootstrap.sh" ]
