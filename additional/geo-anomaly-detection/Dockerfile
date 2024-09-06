FROM python:3.10

WORKDIR /
ADD "https://api.github.com/repos/Master-s-Thesis-IPFIX/geo-anomaly-detection/commits?per_page=1" latest_commit
RUN git clone https://github.com/Master-s-Thesis-IPFIX/geo-anomaly-detection.git

WORKDIR /geo-anomaly-detection
RUN pip install -r requirements.txt

# faust -A main worker -l info
ENTRYPOINT [ "faust", "-A", "main", "worker", "-l", "info" ]
