#!/bin/bash

# Check environment variables
if [ -z "${DATABASE_NAME}" ] || [ -z "${DATABASE_USER}" ] || [ -z "${DATABASE_PASSWORD}" ]; then
    echo "❌ ERROR: One or more required environment variables are not set."
    echo "DATABASE_NAME=${DATABASE_NAME}"
    echo "DATABASE_USER=${DATABASE_USER}"
    echo "DATABASE_PASSWORD=${DATABASE_PASSWORD}"
    exit 1
fi

echo "✅ Starting MariaDB service..."
service mariadb start

# Wait for MariaDB to become ready
echo "⏳ Waiting for MariaDB to start..."
until mariadb -e "SELECT 1" &>/dev/null; do
    sleep 1
done
echo "✅ MariaDB is ready."

# Initialize database and user
echo "🔧 Setting up database and user..."
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DATABASE_NAME}\`;"
mariadb -e "CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${DATABASE_NAME}\`.* TO '${DATABASE_USER}'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
echo "✅ Database and user setup complete."

# Shutdown service cleanly
echo "🛑 Shutting down temporary MariaDB..."
mysqladmin -uroot shutdown
sleep 2

# Start MariaDB in the foreground (for Docker)
echo "🚀 Starting MariaDB on 0.0.0.0:3306"
exec mysqld_safe --bind-address=0.0.0.0 --port=3306
