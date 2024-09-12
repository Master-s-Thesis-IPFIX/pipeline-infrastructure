FROM pypy:3.10

ARG LIBFIXBUF_VERSION=2.4.2
ARG PYBFIXBUF_VERSION=0.9.0

RUN mkdir /build /build/libfixbuf /build/pyfixbuf

RUN apt-get update && apt-get install -y libpcap-dev parallel

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
ADD "https://api.github.com/repos/Master-s-Thesis-IPFIX/malfix/commits?per_page=1&sha=feature/ipfix" latest_commit
RUN git clone -b feature/ipfix https://github.com/Master-s-Thesis-IPFIX/malfix.git

WORKDIR /malfix
RUN pip install -r requirements.txt 

ENTRYPOINT [ "./run_parallel.sh" ]
CMD [ "-n" ,"4", "-h", "goflow2", "-P", "tcp", "-", "--ipfix_forward" ]
