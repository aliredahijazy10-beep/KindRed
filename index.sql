CREATE DATABASE kindred;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  phone_nb VARCHAR(30),
  role ENUM('user','admin') NOT NULL UNIQUE,
  created_at DATETIME NOT NULL DEFAULT NOW(),
);

CREATE TABLE user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  role ENUM('user','admin') NOT NULL DEFAULT 'user',
  blood_type ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  city VARCHAR(80) NOT NULL,
  birth_date DATE NOT NULL,
  gender ENUM('male','female') NOT NULL,
  weight_kg DECIMAL(5,2),
  medical_notes TEXT,
  last_donation_date DATE,
  user_id INT,
  CONSTRAINT check_user_role CHECK (role = 'user'),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE admin (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  work_email VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  phone_nb VARCHAR(30),
  organization VARCHAR(100) NOT NULL,
  position VARCHAR(100) NOT NULL,
  work_city VARCHAR(255) NOT NULL,
  role ENUM('user','admin') NOT NULL DEFAULT 'admin',
  admin_id INT,
  CONSTRAINT check_admin_role CHECK (role = 'admin'),
  FOREIGN KEY (admin_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE requests (
  id INT AUTO_INCREMENT PRIMARY KEY,
  patient_name VARCHAR(100) NOT NULL,
  blood_type ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  city VARCHAR(80) NOT NULL,
  hospital_name VARCHAR(100) NOT NULL,
  request_date DATETIME NOT NULL DEFAULT NOW(),
  needed_by_date DATETIME NOT NULL,
  urgency ENUM('critical','high','standard') NOT NULL DEFAULT 'standard',
  status ENUM('pending','accepted','rejected') NOT NULL DEFAULT 'pending',
  admin_id INT,
  FOREIGN KEY (admin_id) REFERENCES admin(id) ON DELETE CASCADE
);

CREATE TABLE responded_requests (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  request_id INT,
  responded_at DATETIME NOT NULL DEFAULT NOW(),
  status ENUM('pending','accepted','rejected') NOT NULL DEFAULT 'pending',
  FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
  FOREIGN KEY (request_id) REFERENCES requests(id) ON DELETE CASCADE
);