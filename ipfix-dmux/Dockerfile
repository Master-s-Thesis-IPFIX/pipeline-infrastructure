FROM python:3.10

ARG LIBFIXBUF_VERSION=2.4.2
ARG PYBFIXBUF_VERSION=0.9.0

RUN mkdir /build /build/libfixbuf /build/pyfixbuf

WORKDIR /build 

RUN wget https://tools.netsa.cert.org/releases/libfixbuf-${LIBFIXBUF_VERSION}.tar.gz -O libfixbuf.tar.gz &&\
    wget https://tools.netsa.cert.org/releases/pyfixbuf-${PYBFIXBUF_VERSION}.tar.gz -O pyfixbuf.tar.gz

RUN tar -xzf libfixbuf.tar.gz -C libfixbuf --strip-components=1 --no-same-owner &&\
    tar -xzf pyfixbuf.tar.gz -C pyfixbuf --strip-components=1 --no-same-owner

WORKDIR /build/libfixbuf
RUN ./configure && make && make install

WORKDIR /build/pyfixbuf
RUN python setup.py build && python setup.py install && ldconfig

WORKDIR /
ADD "https://api.github.com/repos/JSteegmueller/ipfix-demux/commits?per_page=1" latest_commit
RUN git clone https://github.com/JSteegmueller/ipfix-demux.git

WORKDIR /ipfix-demux
ENTRYPOINT [ "python", "-u", "main.py" ,"--malfix_instances", "1", "--malfix_hostname", "127.0.0.1", "--malfix_protocol", "tcp"]
