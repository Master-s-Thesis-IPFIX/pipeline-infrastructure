FROM fedora:39

ARG LIBFIXBUF_VERSION=2.4.2
ARG SILK_VERSION=3.22.2

RUN mkdir /build /build/libfixbuf /build/silk /data

WORKDIR /build 

RUN sudo yum -y install gcc gcc-c++ make pkgconfig glib2 glib2-devel libpcap libpcap-devel pcre pcre-devel wget iproute

RUN wget https://tools.netsa.cert.org/releases/libfixbuf-${LIBFIXBUF_VERSION}.tar.gz -O libfixbuf.tar.gz &&\
    wget https://tools.netsa.cert.org/releases/silk-${SILK_VERSION}.tar.gz -O silk.tar.gz

RUN tar -xzf libfixbuf.tar.gz -C libfixbuf --strip-components=1 &&\
    tar -xzf silk.tar.gz -C silk --strip-components=1


WORKDIR /build/libfixbuf
RUN ./configure && make && make install

WORKDIR /build/silk
RUN ./configure --enable-ipv6 && make && make install
RUN cp site/twoway/silk.conf /data

WORKDIR /data
COPY sensor.conf .

WORKDIR /
COPY start.sh .
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]
