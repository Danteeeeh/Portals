<?php
class Database {
    private $host = 'localhost';
    private $username = 'root';
    private $password = '';
    private $database = 'siasystem';
    private $conn;

    public function __construct() {
        try {
            // First try to connect without database
            $this->conn = new mysqli($this->host, $this->username, $this->password);
            if ($this->conn->connect_error) {
                throw new Exception('Connection failed: ' . $this->conn->connect_error);
            }

            // Create database if it doesn't exist
            $this->conn->query("CREATE DATABASE IF NOT EXISTS {$this->database}");
            
            // Select the database
            $this->conn->select_db($this->database);
            
        } catch (Exception $e) {
            error_log('Database Connection Error: ' . $e->getMessage());
            die('Database connection failed. Please try again later.');
        }
    }

    public function getConnection() {
        return $this->conn;
    }

    public function query($sql) {
        try {
            $result = $this->conn->query($sql);
            if ($result === false) {
                throw new Exception('Query failed: ' . $this->conn->error);
            }
            return $result;
        } catch (Exception $e) {
            error_log('Database Query Error: ' . $e->getMessage());
            return false;
        }
    }

    public function prepare($sql) {
        try {
            $stmt = $this->conn->prepare($sql);
            if ($stmt === false) {
                throw new Exception('Prepare failed: ' . $this->conn->error);
            }
            return $stmt;
        } catch (Exception $e) {
            error_log('Database Prepare Error: ' . $e->getMessage());
            return false;
        }
    }

    public function escape($value) {
        return $this->conn->real_escape_string($value);
    }

    public function insert($table, $data) {
        $columns = implode(', ', array_keys($data));
        $values = implode(', ', array_map(function($value) {
            return "'" . $this->escape($value) . "'";
        }, array_values($data)));
        
        $sql = "INSERT INTO {$table} ({$columns}) VALUES ({$values})";
        return $this->query($sql);
    }

    public function update($table, $data, $where) {
        $set = implode(', ', array_map(function($key, $value) {
            return "{$key} = '" . $this->escape($value) . "'";
        }, array_keys($data), array_values($data)));
        
        $sql = "UPDATE {$table} SET {$set} WHERE {$where}";
        return $this->query($sql);
    }

    public function __destruct() {
        if ($this->conn) {
            $this->conn->close();
        }
    }
}
