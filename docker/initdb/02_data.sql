--  categories 
INSERT INTO categories (id, name, description) VALUES
  (1, 'Zapatillas Urbanas', 'Zapatillas para uso diario en ciudad'),
  (2, 'Zapatillas Running', 'Zapatillas para correr y entrenamiento'),
  (3, 'Zapatillas Lifestyle', 'Modelos de moda casual');

-- atributos 
INSERT INTO attributes (id, name) VALUES
  (1, 'Talla'),
  (2, 'Color'),
  (3, 'Material');

-- oroductos 
INSERT INTO products (id, name, description, price, stock, category_id, store_id, created_at)
VALUES
  (1, 'Urban Runner X1', 'Zapatillas urbanas cómodas y ligeras', 120.00, 1, 1, 1, NOW()),
  (2, 'Speed Max 500', 'Zapatillas de running para alta velocidad', 150.00, 30, 2, 1, NOW()),
  (3, 'Retro Style 70', 'Zapatillas estilo retro para evento casual', 100.00, 20, 3, 1, NOW()),
  (4, 'City Walk 2.0', 'Perfectas para caminar largo en la ciudad', 110.00, 40, 1, 1, NOW()),
  (5, 'Marathon Pro', 'Zapatillas para maratón con amortiguación avanzada', 180.00, 25, 2, 1, NOW());

--  Imagenes de Productos 
INSERT INTO product_images (product_id, url) VALUES
  -- Urban Runner X1
  (1, 'https://example.com/img/urban_runner_x1_1.jpg'),
  (1, 'https://example.com/img/urban_runner_x1_2.jpg'),
  (1, 'https://example.com/img/urban_runner_x1_3.jpg'),

  -- Speed Max 500
  (2, 'https://example.com/img/speed_max_500_1.jpg'),
  (2, 'https://example.com/img/speed_max_500_2.jpg'),
  (2, 'https://example.com/img/speed_max_500_3.jpg'),

  -- Retro Style 70
  (3, 'https://example.com/img/retro_style_70_1.jpg'),
  (3, 'https://example.com/img/retro_style_70_2.jpg'),
  (3, 'https://example.com/img/retro_style_70_3.jpg'),

  -- City Walk 2.0
  (4, 'https://example.com/img/city_walk_2_1.jpg'),
  (4, 'https://example.com/img/city_walk_2_2.jpg'),
  (4, 'https://example.com/img/city_walk_2_3.jpg'),

  -- Marathon Pro
  (5, 'https://example.com/img/marathon_pro_1.jpg'),
  (5, 'https://example.com/img/marathon_pro_2.jpg'),
  (5, 'https://example.com/img/marathon_pro_3.jpg');

-- Valores de Atributos 
INSERT INTO product_attribute_values (product_id, attribute_id, value) VALUES
  (1, 1, '42'), (1, 2, 'Negro'), (1, 3, 'Malla'),
  (2, 1, '44'), (2, 2, 'Azul'), (2, 3, 'Sintético'),
  (3, 1, '41'), (3, 2, 'Blanco'), (3, 3, 'Cuero'),
  (4, 1, '43'), (4, 2, 'Gris'), (4, 3, 'Malla'),
  (5, 1, '45'), (5, 2, 'Rojo'), (5, 3, 'Sintético');

-- Descuentos Activos 
INSERT INTO product_discounts (product_id, percentage, start_date, end_date, active) VALUES
  (1, 10.00, NOW() - INTERVAL 1 DAY, NOW() + INTERVAL 6 DAY, TRUE),
  (3, 15.00, NOW(), NOW() + INTERVAL 5 DAY, TRUE);

