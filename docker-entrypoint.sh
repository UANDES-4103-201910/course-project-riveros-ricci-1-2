#!/bin/bash

echo "Creating database if it's not present..."
bin/rails db:create

echo "Migrating database..."
bin/rails db:migrate

# If the container has been killed, there may be a stale pid file
# preventing rails from booting up
rm -f tmp/pids/server.pid

exec "$@"
