FROM netsampler/goflow2
COPY mapping.yaml .

ENTRYPOINT ["./goflow2", "-mapping", "mapping.yaml", \
                         "-transport=kafka", \
                         "-transport.kafka.brokers=kafka:9092", \
                         "-transport.kafka.topic=malfix", \
                         "-format=bin", \
                         "-transport.kafka.compression=lz4", \
                         "-listen=netflow://:2055/?count=8" ]
