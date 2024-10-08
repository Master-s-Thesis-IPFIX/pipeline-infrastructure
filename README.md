## Overview

This project orchestrates several services using Docker Compose to create a comprehensive network analysis and anomaly detection system. Each service plays a specific role in the data processing pipeline.

## Services

### yaf
`yaf` is a tool for network flow analysis. It captures and processes network traffic. This service runs in host network mode for direct access to network interfaces and has enhanced networking capabilities.

### super_mediator
`super_mediator` acts as a central coordinator in the system, managing data flow between various components. It listens on port `18000` and ensures proper communication between services.

### ipfix-load-balancer
The `ipfix-load-balancer` service distributes IPFIX (IP Flow Information Export) data across different components to balance the load. It listens on port `18500` and ensures that data is efficiently routed to the appropriate destinations.

### malfix
`malfix` is responsible for analyzing and detecting malicious network traffic. It runs with a specific volume for storing its data and listens on a range of ports (`19000-19100`) for incoming traffic. This service depends on `goflow2` for flow data processing.

### goflow2
`goflow2` processes network flow data and integrates with Kafka for real-time data streaming. It listens on UDP port `2055` and is essential for feeding data into the Kafka system for further processing.

### kafka
`kafka` serves as a distributed streaming platform, handling real-time data feeds from other services. It acts as the backbone of the data pipeline, ensuring reliable data transfer and storage. Kafka is configured with specific roles and settings for optimal performance.

### geo-anomaly-detection
The `geo-anomaly-detection` service analyzes geolocation data to detect anomalies and irregularities. It relies on Kafka for real-time data streaming and processing.

## Volumes

- **malfix**: This volume is used by the `malfix` service to persist its data, ensuring that analysis results are retained across container restarts.

## Usage

To build and start all services, use the following command:

```bash
sudo docker compose up
```

This command will build the necessary Docker images and start each service, initializing the network analysis and anomaly detection pipeline.

## Additional Information

For further details on each service, consult the respective Dockerfile or service documentation within the project directories.
