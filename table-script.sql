-- Table Creation Script

Create Table Customers (
  id INT PRIMARY Key,
  firstname VARCHAR(255) NOT NULL,
  lastname VARCHAR(255),
  login VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(25) NOT NULL,
  contact_number VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE Table Items (
  id INT PRIMARY Key,
  name VARCHAR(255),
  description VARCHAR (1000),
  image_url VARCHAR (300),
  price DECIMAL(8, 2),
  in_stock CHAR(1) CHECK (in_stock IN ("Y", "N")),
  quantity_in_stock INT,
  average_rating FLOAT,
  category_id INT,
);

CREATE Table Cart (
  customer_id INT,
  item_id INT,
  quantity INT
  PRIMARY Key (customer_id, item_id)
  CONSTRAINT fk_cart_customer FOREIGN Key (customer_id) REFERENCES Customers(id),
  CONSTRAINT fk_cart_item FOREIGN Key (item_id) REFERENCES Items(id)
);

CREATE Table Orders (
  id INT PRIMARY Key,
  customer_id INT,
  status VARCHAR (255),
  total_price DECIMAL(8,2),
  used_loyalty_points CHAR(1) CHECK (used_loyalty_points IN ("Y", "N")),
  pickup_location VARCHAR (1000),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE Table OrderItems (
  order_id INT,
  item_id INT,
  item_name VARCHAR (255),
  item_price DECIMAL(8,2),
  quantity INT

  PRIMARY Key (order_id, item_id)
  CONSTRAINT fk_oi_order FOREIGN KEY (order_id) REFERENCES Orders(id)
  CONSTRAINT fk_oi_item FOREIGN KEY (item_id) REFERENCES Items(id)
);

CREATE Table Categories (
  id INT PRIMARY Key,
  name VARCHAR(255),
  description VARCHAR(2000)
);

CREATE Table Promotions (
  id INT PRIMARY Key,
  name VARCHAR (255),
  description VARCHAR (1000),
  discount_percent INT,
  start_date TIMESTAMP,
  end_date TIMESTAMP,
  applicable_item_id INT,

  CONSTRAINT fk_promo_item FOREIGN Key (applicable_item_id) REFERENCES Items(id)
);

CREATE Table Ratings (
  id INT PRIMARY KEY,
  customer_id INT,
  item_id INT,
  rating FLOAT,
  review VARCHAR (5000)

  CONSTRAINT fk_ratings_customer FOREIGN Key (customer_id) REFERENCES Customers(id)
  CONSTRAINT fk_ratings_item FOREIGN Key (item_id) REFERENCES Items(id)
);

CREATE Table LoyaltyPrograms (
  id INT,
  name VARCHAR (255),
  tier VARCHAR (255),
  description VARCHAR (255),
  points_required INT,
  applied_when TIMESTAMP,
);

CREATE Table LoyaltyPoints (
  customer_id INT,
  loyalty_id INT,
  points_balance INT

  PRIMARY Key (customer_id, loyalty_id)
  CONSTRAINT fk_points_customer FOREIGN Key (customer_id) REFERENCES Customers(id)
  CONSTRAINT fk_points_programs FOREIGN Key (loyalty_id) REFERENCES LoyaltyPrograms(id)
);

CREATE Table LoyaltyItems (
  loyalty_id INT,
  item_id INT

  PRIMARY Key (loyalty_id, item_id)
  CONSTRAINT fk_points_programs FOREIGN Key (loyalty_id) REFERENCES LoyaltyPrograms(id)
  CONSTRAINT fk_points_item FOREIGN Key (item_id) REFERENCES Items(id)

);






