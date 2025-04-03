<?php
// ./php-fpm/src/index.php

echo "<h1>Hello from PHP-FPM!</h1>";

echo "<h2>PHP Info</h2>";
phpinfo();

// Database connection details from environment variables (defined in docker-compose.yml)
$pg_host = getenv('DB_POSTGRES_HOST');
$pg_port = getenv('DB_POSTGRES_PORT');
$pg_db   = getenv('DB_POSTGRES_DATABASE');
$pg_user = getenv('DB_POSTGRES_USER');
$pg_pass = getenv('DB_POSTGRES_PASSWORD');

$maria_host = getenv('DB_MARIADB_HOST');
$maria_port = getenv('DB_MARIADB_PORT');
$maria_db   = getenv('DB_MARIADB_DATABASE');
$maria_user = getenv('DB_MARIADB_USER');
$maria_pass = getenv('DB_MARIADB_PASSWORD');

echo "<h2>Database Connection Test</h2>";

// Test PostgreSQL Connection
echo "<h3>PostgreSQL</h3>";
try {
    $dsn_pg = "pgsql:host={$pg_host};port={$pg_port};dbname={$pg_db}";
    $pdo_pg = new PDO($dsn_pg, $pg_user, $pg_pass, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    echo "<p style='color:green;'>Successfully connected to PostgreSQL database '{$pg_db}' on host '{$pg_host}'.</p>";
    // Check server version
    $stmt = $pdo_pg->query('SELECT version()');
    $version = $stmt->fetchColumn();
    echo "<p>PostgreSQL Version: " . htmlspecialchars($version) . "</p>";
    $pdo_pg = null; // Close connection
} catch (PDOException $e) {
    echo "<p style='color:red;'>PostgreSQL Connection Failed: " . htmlspecialchars($e->getMessage()) . "</p>";
}

// Test MariaDB Connection
echo "<h3>MariaDB</h3>";
try {
    $dsn_maria = "mysql:host={$maria_host};port={$maria_port};dbname={$maria_db};charset=utf8mb4";
    $pdo_maria = new PDO($dsn_maria, $maria_user, $maria_pass, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    echo "<p style='color:green;'>Successfully connected to MariaDB database '{$maria_db}' on host '{$maria_host}'.</p>";
    // Check server version
    $stmt = $pdo_maria->query('SELECT version()');
    $version = $stmt->fetchColumn();
    echo "<p>MariaDB Version: " . htmlspecialchars($version) . "</p>";
    $pdo_maria = null; // Close connection
} catch (PDOException $e) {
    echo "<p style='color:red;'>MariaDB Connection Failed: " . htmlspecialchars($e->getMessage()) . "</p>";
}

?>