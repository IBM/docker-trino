FROM prestosql/presto:325

# Add Db2 connector
COPY --chown=presto:presto presto-db2-325 /usr/lib/presto/plugin/db2
