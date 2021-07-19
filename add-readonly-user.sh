#!/bin/bash
set -e

echo "
    CREATE ROLE readonly;
    GRANT CONNECT ON DATABASE postgres TO readonly;
    GRANT USAGE ON SCHEMA public TO readonly;
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;
    CREATE USER ${READONLY_USER} WITH PASSWORD '${READONLY_PASSWORD}';
    GRANT readonly TO ${READONLY_USER};
" | psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB"
