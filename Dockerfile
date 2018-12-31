FROM openjdk:8u181-jre-stretch

LABEL MAINTAINER=shawnzhu@users.noreply.github.com

ENV PRESTO_VERSION=0.193
ENV PRESTO_HOME=/opt/presto

# extra dependency for running launcher
RUN apt-get update && apt-get install -y --no-install-recommends \
		python2.7-minimal \
	&& rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python2.7 /usr/bin/python

RUN curl -L https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz -o /tmp/presto-server.tgz && \
    tar -xzf /tmp/presto-server.tgz -C /opt && \
    ln -s /opt/presto-server-${PRESTO_VERSION} ${PRESTO_HOME} && \
    mkdir -p ${PRESTO_HOME}/data && \
    rm -f /tmp/presto-server.tgz

RUN curl -L https://github.com/IBM/presto-db2/releases/download/${PRESTO_VERSION}/presto-db2-${PRESTO_VERSION}.zip -o /tmp/presto-db2.zip && \
    unzip /tmp/presto-db2.zip -d ${PRESTO_HOME}/plugin/ && \
    mv ${PRESTO_HOME}/plugin/presto-db2-${PRESTO_VERSION} ${PRESTO_HOME}/plugin/db2 && \
    rm -f /tmp/presto-db2.zip

COPY etc ${PRESTO_HOME}/etc
EXPOSE 8080

VOLUME ["${PRESTO_HOME}/etc", "${PRESTO_HOME}/data"]

WORKDIR ${PRESTO_HOME}

ENTRYPOINT ["./bin/launcher"]

CMD ["run"]
