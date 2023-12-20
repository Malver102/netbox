#!/bin/bash

DB_NAME="netbox"
DB_USER="netbox_db"
DB_USER_PASS="netbox"


psql -U amdin "CREATE USER $DB_USER WITH PASSWORD '$DB_USER_PASS';"
psql -U admin "ALTER DATABASE '$DB_NAME' OWNET TO '$DB_USER_PASS';"
psql -U admin "grant all privileges on database $DB_NAME to $DB_USER;"
psql -U admin "GRANT CREATE ON SCHEMA public TO '$DB_NAME';"
