CREATE DATABASE nn84_system;

USE nn84_system;

# Tabela para registrar usuários da plataforma
CREATE TABLE nn84_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    name VARCHAR(80) NOT NULL,
    email VARCHAR(120) NOT NULL,
    password VARCHAR(255) NOT NULL,
    
    role ENUM('user', 'admin') NOT NULL,
    status ENUM('active', 'inactive') NOT NULL,
    created_at TIMESTAMP NOT NULL 
);

# Tabela para registar conteúdo do perfil/background do usuário na plataforma
CREATE TABLE nn84_users_profile (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    profile_url VARCHAR(255), # foto de perfil do usuário
    background_url VARCHAR(255), # foto de fundo do perfil do usuário
    
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES nn84_users(id)
);

# Tabela para registrar os posts da plataforma
CREATE TABLE nn84_posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    title VARCHAR(150),
    slug VARCHAR(160), # url do produto criada a partir do título 
    body TEXT,
    status ENUM('rascunho', 'publicado'),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES nn84_categories(id)
);

# Tabela para registar as imagens da postagem na plataforma
CREATE TABLE nn84_posts_photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    path VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    
    post_id INT,
    FOREIGN KEY (post_id) REFERENCES nn84_posts(id)
);

# Tabela para registrar as categorias das postagens na plataforma
CREATE TABLE nn84_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    name VARCHAR(80),
    description VARCHAR(255), # estabelece descrição para a categoria
    status ENUM('active', 'inactive') NOT NULL, # ocultar categoria na plataforma sem precisar deletar
    
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

# Tabela para registar informações a respeito de uma postagem na plataforma
CREATE TABLE nn84_post_views (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    view_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    updated_at TIMESTAMP,
    
    post_id INT,
    FOREIGN KEY (post_id) REFERENCES nn84_posts(id)
);

# Tabela para registrar o comentário do usuário referente a postagem
CREATE TABLE nn84_comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    comment VARCHAR(255),
    status ENUM('active', 'inactive'),

    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    
    post_id INT,
    user_id INT,
    FOREIGN KEY (post_id) REFERENCES nn84_posts(id),
    FOREIGN KEY (user_id) REFERENCES nn84_users(id)
);

