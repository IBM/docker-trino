FROM bde2020/hadoop-base:1.1.0-hadoop2.8-java8
MAINTAINER kzhu

ENV PRESTO_VERSION=0.181
ENV PRESTO_HOME=/opt/presto

ADD https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz /opt

RUN ln -s /opt/presto-server-${PRESTO_VERSION} ${PRESTO_HOME} && \
    mkdir -p ${PRESTO_HOME}/data

COPY etc ${PRESTO_HOME}/etc
EXPOSE 8080

VOLUME ["${PRESTO_HOME}/etc", "${PRESTO_HOME}/data"]

WORKDIR ${PRESTO_HOME}

CMD ["./bin/launcher", "run"]
