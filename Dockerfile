FROM openjdk:8-jdk-alpine
LABEL maintainer="yankolyaspas@gmail.com"
ARG JAR_FILE=target/flink-quickstart-java-1.0-SNAPSHOT.jar
ADD ${JAR_FILE} flinkjob.jar
RUN apk add --no-cache curl
RUN ["curl", "-o", "flink.tgz", "http://apache.volia.net/flink/flink-1.7.2/flink-1.7.2-bin-scala_2.12.tgz"]
RUN ["tar", "xzf", "flink.tgz"]
COPY /flink-conf.yaml flink-1.7.2/conf/flink-conf.yaml
RUN cp flink-1.7.2/opt/flink-metrics-prometheus-1.7.2.jar flink-1.7.2/lib/flink-metrics-prometheus-1.7.2.jar
RUN apk add --no-cache bash
ENTRYPOINT flink-1.7.2/bin/start-cluster.sh && flink-1.7.2/bin/flink run -c org.apache.flink.WikipediaAnalysisJob flinkjob.jar
EXPOSE 8081 9249