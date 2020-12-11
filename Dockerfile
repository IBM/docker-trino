FROM prestosql/presto:340

# Add Db2 connector
COPY --chown=presto:presto presto-db2-340 /usr/lib/presto/plugin/db2
