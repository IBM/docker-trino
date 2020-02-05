FROM prestosql/presto:329

# Add Db2 connector
COPY --chown=presto:presto presto-db2-329 /usr/lib/presto/plugin/db2
