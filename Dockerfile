FROM prestosql/presto:347

USER root
# Update centos packages
RUN dnf update -y

USER presto:presto
# Add Db2 connector
COPY --chown=presto:presto presto-db2-347 /usr/lib/presto/plugin/db2
