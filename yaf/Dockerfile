FROM fedora:39

ARG LIBFIXBUF_VERSION=2.4.2
ARG YAF_VERSION=2.15.0

RUN mkdir /build /build/libfixbuf /build/yaf

WORKDIR /build 

RUN sudo yum -y install gcc gcc-c++ make pkgconfig glib2 glib2-devel libpcap libpcap-devel pcre pcre-devel wget iproute

RUN wget https://tools.netsa.cert.org/releases/libfixbuf-${LIBFIXBUF_VERSION}.tar.gz -O libfixbuf.tar.gz &&\
    wget https://tools.netsa.cert.org/releases/yaf-${YAF_VERSION}.tar.gz -O yaf.tar.gz

RUN tar -xzf libfixbuf.tar.gz -C libfixbuf --strip-components=1 &&\
    tar -xzf yaf.tar.gz -C yaf --strip-components=1

WORKDIR /build/libfixbuf
RUN ./configure && make && make install

WORKDIR /build/yaf
RUN ./configure --enable-applabel --enable-plugins && make && make install

WORKDIR /usr/local/etc
COPY yaf.conf .

ENTRYPOINT [ "yaf" , "--config" , "/usr/local/etc/yaf.conf" ]
