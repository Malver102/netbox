#!/bin/bash


set -e
DB_NAME="netbox"
DB_USER="netbox_db"
DB_USER_PASS="netbox"

postgres <<EOF
createdb  $DB_NAME;
psql -c "CREATE USER $DB_USER WITH PASSWORD '$DB_USER_PASS';"
psql -c "ALTER DATABASE '$DB_NAME' OWNET TO '$DB_USER_PASS';"
psql -c "grant all privileges on database $DB_NAME to $DB_USER;"
psql -c "GRANT CREATE ON SCHEMA public TO '$DB_NAME';"
echo "Postgres User '$DB_USER' and database '$DB_NAME' created."
EOF