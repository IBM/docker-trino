FROM prestosql/presto:337

# Add Db2 connector
COPY --chown=presto:presto presto-db2-337 /usr/lib/presto/plugin/db2
