FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    git \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/MTProxy

COPY . .

RUN make

ENV PORT=443
ENV SECRET=1234567890abcdef1234567890abcdef

CMD ./objs/bin/mtproto-proxy -u nobody -p 8888 -H ${PORT} -S ${SECRET} --aes-pwd proxy-secret proxy-multi.conf -M 1
