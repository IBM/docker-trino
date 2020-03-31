FROM prestosql/presto:331

# Add Db2 connector
COPY --chown=presto:presto presto-db2-331 /usr/lib/presto/plugin/db2
