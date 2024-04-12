FROM alpine

ARG NFDUMP_VERSION=1.7.4

RUN mkdir /build /build/nfdump /data

WORKDIR /build 

RUN apk add --no-cache libtool bzip2-dev 
RUN apk add --no-cache --virtual build-deps libtool autoconf automake m4 pkgconfig make g++ flex byacc 

RUN wget https://github.com/phaag/nfdump/archive/refs/tags/v1.7.4.tar.gz -O nfdump.tar.gz

RUN tar -xzf nfdump.tar.gz -C nfdump --strip-components=1

WORKDIR /build/nfdump
RUN ./autogen.sh && ./configure && make && make install

ENTRYPOINT [ "nfcapd", "-E" , "-p" , "8888" , "-w", "/data" ]
