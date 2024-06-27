FROM netsampler/goflow2
COPY mapping.yaml .

ENTRYPOINT ["./goflow2", "-mapping", "mapping.yaml", \
                         "-transport=kafka", \
                         "-transport.kafka.brokers=broker:19092", \
                         "-transport.kafka.topic=flows", \
                         "-format=text", \
                         "-addr=:8081", \
                         "-transport.kafka.compression=lz4", \
                         "-listen=netflow://:2055/?count=8" ]
