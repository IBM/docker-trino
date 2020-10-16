FROM centos:centos8

ARG PRESTO_VERSION

ENV JAVA_HOME /usr/lib/jvm/zulu11
ENV LANG en_US.UTF-8

RUN \
    set -xeu && \
    dnf -y -q install https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm && \
    dnf -y -q update && \
    dnf -y -q install zulu11 less python3 && \
    alternatives --set python /usr/bin/python3 && \
    rpm -i --nodeps https://repo1.maven.org/maven2/io/prestosql/presto-server-rpm/${PRESTO_VERSION}/presto-server-rpm-${PRESTO_VERSION}.rpm && \
    dnf -q clean all && \
    rm -rf /var/cache/dnf && \
    rm -rf /tmp/* /var/tmp/* && \
    mkdir -p /usr/lib/presto /data/presto && \
    chown -R "presto:presto" /usr/lib/presto /data/presto

ADD https://repo1.maven.org/maven2/io/prestosql/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar /usr/bin/presto
COPY bin/run-presto /usr/lib/presto/bin/

RUN chmod 0755 /usr/bin/presto && \
    chmod 0755 /usr/lib/presto/bin/run-presto

EXPOSE 8080
USER presto:presto

CMD ["/usr/lib/presto/bin/run-presto"]

# Add Db2 connector
COPY --chown=presto:presto presto-db2-${PRESTO_VERSION} /usr/lib/presto/plugin/db2
