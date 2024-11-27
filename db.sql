CREATE TABLE users (
    id VARCHAR(11) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    balance DECIMAL(10,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transactions table
CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id VARCHAR(11),
    receiver_id VARCHAR(11),
    amount DECIMAL(10,2) NOT NULL,
    admin_fee DECIMAL(10,2) DEFAULT 2500,
    type ENUM('transfer', 'topup', 'request') NOT NULL,
    payment_method VARCHAR(20),
    status ENUM('pending', 'success', 'failed') DEFAULT 'success',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id)
);

-- Request codes table
CREATE TABLE request_codes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(11),
    barcode VARCHAR(100) UNIQUE NOT NULL,
    amount DECIMAL(10,2),
    status ENUM('active', 'used', 'expired') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);