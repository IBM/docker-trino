FROM prestosql/presto:338

# Add Db2 connector
COPY --chown=presto:presto presto-db2-338 /usr/lib/presto/plugin/db2
