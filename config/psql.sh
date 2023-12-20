#!/bin/bash

DB_NAME="netbox_db"
DB_USER="netbox"
DB_USER_PASS="netbox"

psql -U postgres -h localhost -c "CREATE DATABASE $DB_NAME;"
psql -U postgres -h localhost -c "CREATE USER $DB_USER WITH PASSWORD '$DB_USER_PASS';"
psql -U postgres -h localhost -c "ALTER DATABASE '$DB_NAME' OWNET TO '$DB_USER_PASS';"
psql -U postgres -h localhost -c "grant all privileges on database $DB_NAME to $DB_USER;"
psql -U postgres -h localhost -c "GRANT CREATE ON SCHEMA public TO '$DB_NAME';"
