#!/bin/bash

for instances in 1 2 4 8 16 32; do
  max_flows=$((500000 * instances))
  for i in {1..4}; do
    sudo docker run --network host demux \
      --malfix_instances $instances \
      --malfix_hostname steegmueller-2 \
      --malfix_protocol tcp \
      --max_flows $max_flows \
      --malicious_percentage 100 \
      --malicious_types ip,dns \
      --benchmark \
      --minimal_log
  done
done
