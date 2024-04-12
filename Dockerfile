FROM fedora:39

ARG LIBFIXBUF_VERSION=2.4.2
ARG YAF_VERSION=2.15.0
ARG SUPER_MEDIATOR_VERSION=1.10.1

RUN mkdir /build /build/libfixbuf /build/yaf /build/super_mediator

WORKDIR /build 

RUN sudo yum -y install gcc gcc-c++ make pkgconfig glib2 glib2-devel libpcap libpcap-devel pcre pcre-devel wget

RUN wget https://tools.netsa.cert.org/releases/libfixbuf-${LIBFIXBUF_VERSION}.tar.gz -O libfixbuf.tar.gz &&\
    wget https://tools.netsa.cert.org/releases/yaf-${YAF_VERSION}.tar.gz -O yaf.tar.gz &&\
    wget https://tools.netsa.cert.org/releases/super_mediator-${SUPER_MEDIATOR_VERSION}.tar.gz -O super_mediator.tar.gz

RUN tar -xzf libfixbuf.tar.gz -C libfixbuf --strip-components=1 &&\
    tar -xzf yaf.tar.gz -C yaf --strip-components=1 &&\
    tar -xzf super_mediator.tar.gz -C super_mediator --strip-components=1


WORKDIR /build/libfixbuf
RUN ./configure && make && make install

WORKDIR /build/yaf
RUN ./configure --enable-applabel --enable-plugins && make && make install

WORKDIR /build/super_mediator
RUN ./configure && make && make install

WORKDIR /usr/local/etc
COPY yaf.conf .
COPY super_mediator.conf .

WORKDIR /
COPY start.sh .
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]
