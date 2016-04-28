FROM ubuntu:trusty

USER root

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y zookeeper openjdk-8-jre-headless tar wget 
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i 's/ROLLINGFILE/CONSOLE/' /etc/zookeeper/conf/environment

ADD start.sh /opt
RUN chmod 777 /opt/start.sh

RUN wget https://www.apache.org/dyn/closer.cgi?path=/kafka/0.9.0.1/kafka_2.10-0.9.0.1.tgz
RUN tar xzvf kafka_2.10-0.9.0.1.tgz -C /opt

ENV KAFKA_HOME /opt/kafka_2.10-0.9.0.1
ADD start-kafka.sh /opt/start-kafka.sh
RUN chmod 777 /opt/start-kafka.sh

RUN bash /opt/start.sh

ENTRYPOINT ["/opt/start-kafka.sh"]
