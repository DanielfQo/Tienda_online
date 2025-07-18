-- ========================
-- DATABASE
-- ========================

CREATE DATABASE IF NOT EXISTS tienda_online;
USE tienda_online;

-- ========================
-- USERS
-- ========================

-- stores

CREATE TABLE stores (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  address     TEXT NOT NULL,
  created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX       idx_store_name (name)
);

CREATE TABLE users (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  birth_date  DATE,
  gender      ENUM('male', 'female', 'other'),
  email       VARCHAR(120) NOT NULL UNIQUE,
  password    VARCHAR(255) NOT NULL,
  role        ENUM('client', 'admin', 'employee') NOT NULL,
  verified    BOOLEAN DEFAULT FALSE,
  store_id    INT,
  created_at  DATETIME,
  photo       VARCHAR(255),
  FOREIGN KEY (store_id) REFERENCES stores(id)
);

CREATE INDEX idx_users_email ON users(email);

-- cliente / admin / empleado

CREATE TABLE clients (
  user_id INT PRIMARY KEY,
  shipping_address VARCHAR(255),
  phone VARCHAR(20),

  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE admins (
  user_id INT PRIMARY KEY,
  access_level INT,

  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE employees (
  user_id  INT PRIMARY KEY,
  position VARCHAR(30),
  hired_at DATETIME,

  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- addresses

CREATE TABLE addresses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT  NOT NULL,
  line VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100),
  postal_code VARCHAR(20),
  country VARCHAR(100) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
 
-- ========================
-- PRODUCTO
-- ========================

CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
);

CREATE TABLE attributes (
  id   INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  sale_price DECIMAL(10,2) NOT NULL,
  purchase_price DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL,
  category_id INT,
  store_id INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
  FOREIGN KEY (store_id) REFERENCES stores(id) ON DELETE SET NULL,
  UNIQUE KEY uq_prod_store_name (store_id,name)
);

CREATE TABLE product_images (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  url VARCHAR(255) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE product_attribute_values (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  attribute_id INT NOT NULL,
  value VARCHAR(100) NOT NULL,

  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  FOREIGN KEY (attribute_id) REFERENCES attributes(id) ON DELETE CASCADE
);

CREATE TABLE product_discounts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  percentage DECIMAL(5,2) NOT NULL,
  start_date DATETIME NOT NULL,
  end_date DATETIME,
  active BOOLEAN DEFAULT TRUE,
  
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- ========================
-- SALES & PAYMENTS
-- ========================

CREATE TABLE payment_methods (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  type ENUM('credit_card','debit_card','cash','bank_transfer') NOT NULL,
  provider VARCHAR(100),
  account_number VARCHAR(50),
  expiration_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE sales (
  id INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT NOT NULL,
  date DATETIME NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  payment_method ENUM('credit_card','debit_card','cash','bank_transfer') NOT NULL,
  status ENUM('pending','paid','cancelled') NOT NULL,
  payment_method_id INT,
  
  FOREIGN KEY (client_id) REFERENCES clients(user_id) ON DELETE CASCADE,
  FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id) ON DELETE SET NULL
);

CREATE TABLE sale_details (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sale_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  purchase_price DECIMAL(10,2) NOT NULL,

  FOREIGN KEY (sale_id) REFERENCES sales(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
);

-- ========================
-- SHOPPING CARTS Y WISHLISTS
-- ========================


CREATE TABLE shopping_carts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES clients(user_id) ON DELETE CASCADE
);

CREATE TABLE wishlists (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  client_id  INT NOT NULL,
  name       VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES clients(user_id) ON DELETE CASCADE
);

-- ========================
-- GASTOS
-- ========================

CREATE TABLE expenses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  amount DECIMAL(10,2) NOT NULL,
  category VARCHAR(100)  NOT NULL,
  reason TEXT,
  date DATE NOT NULL,
  client_id INT NOT NULL,
  CONSTRAINT fk_exp_client FOREIGN KEY (client_id) REFERENCES clients(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_exp_client_date ON expenses(client_id,date);

CREATE TABLE loans (
  id INT AUTO_INCREMENT PRIMARY KEY,
  amount DECIMAL(10,2) NOT NULL,
  date DATE NOT NULL,
  term INT NOT NULL,
  status ENUM('pending','approved','rejected','paid') NOT NULL,
  client_id INT NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(user_id) ON DELETE CASCADE
);

CREATE TABLE reports (
  id INT AUTO_INCREMENT PRIMARY KEY,
  type VARCHAR(100) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  generated_by INT,
  format ENUM('PDF','CSV','XLSX') NOT NULL,
  generated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  file_path VARCHAR(255),
  FOREIGN KEY (generated_by) REFERENCES admins(user_id) ON DELETE SET NULL
);

-- ========================
-- eventos
-- ========================

CREATE TABLE events (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  type VARCHAR(100) NOT NULL,
  date DATETIME NOT NULL,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE login_attempts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  success BOOLEAN NOT NULL,
  date DATETIME NOT NULL,
  ip VARCHAR(45),
  
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX idx_login_user_date ON login_attempts(user_id,date);