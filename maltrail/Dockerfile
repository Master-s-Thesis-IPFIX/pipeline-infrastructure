FROM python:3.10

ARG LIBFIXBUF_VERSION=2.4.2
ARG PYBFIXBUF_VERSION=0.9.0

RUN mkdir /build /build/libfixbuf /build/pyfixbuf

RUN apt-get update && apt-get install -y libpcap-dev

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
ADD "https://api.github.com/repos/JSteegmueller/maltrail/commits/7933c6d8a97672b430fbaac0d337e368244893be?per_page=1" latest_commit
RUN git clone -b feature/ipfix https://github.com/JSteegmueller/maltrail.git

WORKDIR /maltrail
RUN pip install -r requirements.txt 

ENTRYPOINT [ "python", "sensor.py", "--ipfix", "-p", "ipfix_info_export", "--ipfix_export_host", "graylog" ]
