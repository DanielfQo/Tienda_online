-- ========================
-- DATABASE ZAPATILLAS
-- ========================

-- Tiendas

INSERT INTO stores (name, address) 
VALUES ('Pimp', 'Av. Paucarpata 321, Arequipa, Peru');

-- Categorías

INSERT INTO categories (name, description) 
VALUES 
  ('Zapatillas Running', 'Zapatillas para correr y entrenamiento'),
  ('Zapatillas Lifestyle', 'Zapatillas casuales para uso diario'),
  ('Zapatillas Basket', 'Zapatillas para jugar baloncesto');

-- Atributos

INSERT INTO attributes (name) 
VALUES 
  ('Marca'),
  ('Color'),
  ('Talla'),
  ('Material'),
  ('Tecnología');

-- Productos

INSERT INTO products (name, description, sale_price, purchase_price, stock, category_id, store_id) 
VALUES 
  ('Nike Air Max 90', 'Clásicas zapatillas con tecnología Air', 549.99, 80.00, 50, 1, 1),
  ('Adidas Ultraboost', 'Amortiguación energética para running', 349.99, 95.00, 30, 1, 1),
  ('New Balance 574', 'Icono de estilo casual', 349.99, 60.00, 40, 2, 1),
  ('Jordan Retro 1', 'Clásicas de baloncesto con estilo retro', 499.99, 110.00, 25, 3, 1),
  ('Puma RS-X', 'Diseño futurista y cómodo', 399.99, 65.00, 35, 2, 1);

-- Imágenes
INSERT INTO product_images (product_id, url) 
VALUES 
  (1, 'https://www.tabas.com.pe/wp-content/uploads/2024/08/Nike-Air-Max-90-CN8490-002-2.jpg'),
  (1, 'https://cdn.runrepeat.com/storage/gallery/product_primary/25010/nike-air-max-90-main-22584742-720.jpg'),
  (2, 'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/fbaf991a78bc4896a3e9ad7800abcec6_9366/Zapatillas_Ultraboost_22_Negro_GZ0127_01_standard.jpg'),
  (3, 'https://e00-expansion.uecdn.es/assets/multimedia/imagenes/2018/03/15/15211061804871.jpg'),
  (4, 'https://goldenstoreperu.com/wp-content/uploads/2023/12/50-1.png'),
  (5, 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,e_sharpen:95,w_2000,h_2000/global/391176/13/sv01/fnd/PER/fmt/png/Zapatillas-RS-X-Suede-unisex');

-- Atributos para Nike Air Max 90 (product_id = 1)
INSERT INTO product_attribute_values (product_id, attribute_id, value) 
VALUES 
  (1, 1, 'Nike'),
  (1, 2, 'Negro/Blanco'),
  (1, 3, '42'),
  (1, 4, 'Cuero/Textil'),
  (1, 5, 'Air Max');

-- Atributos para Adidas Ultraboost (product_id = 2)
INSERT INTO product_attribute_values (product_id, attribute_id, value) 
VALUES 
  (2, 1, 'Adidas'),
  (2, 2, 'Negro'),
  (2, 3, '43'),
  (2, 4, 'Primeknit'),
  (2, 5, 'Boost');

-- Atributos para New Balance 574 (product_id = 3)
INSERT INTO product_attribute_values (product_id, attribute_id, value) 
VALUES 
  (3, 1, 'New Balance'),
  (3, 2, 'Gris/Verde'),
  (3, 3, '44'),
  (3, 4, 'Suede/Textil'),
  (3, 5, 'Encap');

-- Atributos para Jordan Retro 1 (product_id = 4)
INSERT INTO product_attribute_values (product_id, attribute_id, value) 
VALUES 
  (4, 1, 'Jordan'),
  (4, 2, 'Rojo/Negro/Blanco'),
  (4, 3, '42.5'),
  (4, 4, 'Cuero'),
  (4, 5, 'Air Sole');

-- Atributos para Puma RS-X (product_id = 5)
INSERT INTO product_attribute_values (product_id, attribute_id, value) 
VALUES 
  (5, 1, 'Puma'),
  (5, 2, 'Plomo/Azul'),
  (5, 3, '41'),
  (5, 4, 'Textil'),
  (5, 5, 'RS Cushion');