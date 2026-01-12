-- 1️⃣ Create Database
CREATE DATABASE  DSA_learning;
USE DSA_learning;

-- 2️⃣ Users Table (Signup/Login)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,         
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3️⃣ Topics Table
CREATE TABLE IF NOT EXISTS topics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,        
    description TEXT,                   
    video_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 4️⃣ Visuals Table
CREATE TABLE IF NOT EXISTS visuals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    topic_id INT NOT NULL,
    type ENUM('animation','diagram') NOT NULL,
    config JSON,                        
    description TEXT,                    
    FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE
);

-- 5️⃣ Problems Table
CREATE TABLE IF NOT EXISTS problems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    topic_id INT NOT NULL,
    title VARCHAR(150),                  
    description TEXT,                    
    example_input TEXT,
    example_output TEXT,
    difficulty ENUM('Easy','Medium','Hard') DEFAULT 'Easy',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE
);

-- 6️⃣ Solutions Table
CREATE TABLE IF NOT EXISTS solutions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    problem_id INT NOT NULL,
    language VARCHAR(20),               
    solution_text TEXT,                  
    explanation TEXT,                    
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
);

-- 7️⃣ Hints Table
CREATE TABLE IF NOT EXISTS hints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    problem_id INT NOT NULL,
    hint_text TEXT,
    hint_order INT,                      
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
);

-- 8️⃣ User Progress Table
CREATE TABLE IF NOT EXISTS user_progress (
    user_id INT NOT NULL,
    topic_id INT,
    problem_id INT,
    status ENUM('Not Started','In Progress','Solved') DEFAULT 'Not Started',
    PRIMARY KEY(user_id, topic_id, problem_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
);
