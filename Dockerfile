FROM prestosql/presto:347

# Add Db2 connector
COPY --chown=presto:presto presto-db2-347 /usr/lib/presto/plugin/db2
