-- STEP 1 Create a restaurant table and an address table with columns that make sense based on the description above.

CREATE TABLE restaurant (
  id integer PRIMARY KEY,
  name varchar(20),
  descriptions varchar(50),
  rating decimal,
  telephone char(10),
  hours varchar(100)
);

-- STEP 1 Create a restaurant table and an address table with columns that make sense based on the description above.

CREATE TABLE address (
  --STEP 2 assign a primary key to a column for each of the tables, restaurant and address.
  id integer PRIMARY KEY,
  street_address varchar(20),
  street_name varchar(20),
  city varchar(20),
  state varchar(15),
  google_map_link varchar(50),
  --STEP 6 A one-to-one relationship exists when one row in a table links to exactly one row in another table and vice-versa. Which two tables in our schema perfectly address a one-to-one relationship between them?
  restaurant_id integer REFERENCES restaurant(id)
);

-- STEP 3 A category’s id is a 2-character identifier such as ‘C’ for Chicken, ‘HS’ for House Specials and ‘LS’ for Luncheon Specials. For simplicity, the description column can contain information including hours of availability and other miscellaneous information. For most categories, only the id and name columns are sufficient and the description would be null.

CREATE TABLE category (
  --STEP 2 assign a primary key to a column for each of the tables, restaurant and address.
  id char(2) PRIMARY KEY,
  name varchar(20),
  description varchar(200)
);

-- STEP 4 Next, we focus on the dishes inside a category. A dish has a name, price, description and an indicator if it’s hot and spicy.

CREATE TABLE dish (
  id integer PRIMARY KEY,
  name varchar(50),
  description varchar(200),
  hot_and_spicy boolean
);

-- STEP 5 Lastly, we create a table, review which corresponds to a customer review of the restaurant.

CREATE TABLE review (
  id integer PRIMARY KEY,
  rating decimal,
  review varchar(100),
  date date,
  -- STEP 7 A one-to-many relationship exists when one row in a table links to many rows in another table. Which two tables perfectly address a one-to-many relationship between them?
  restaurant_id integer REFERENCES restaurant(id)
);

-- STEP 8 A many-to-many relationship comprises two one-to-many relationships. Which two tables perfectly address a many-to-many relationship between them?

CREATE TABLE categories_dishes (
  category_id char(2) REFERENCES category(id),
  dish_id integer REFERENCES dish(id),
  price money,
  PRIMARY KEY (category_id, dish_id)
);

-- STEP 9 Now, it’s time to populate the schema with our sample data

/* 
 *--------------------------------------------
 Insert values for restaurant
 *--------------------------------------------
 */

INSERT INTO restaurant VALUES (
  1,
  'Bytes of China',
  'Delectable Chinese Cuisine',
  3.9,
  '6175551212',
  'Mon - Fri 9:00 am to 9:00 pm, Weekends 10:00 am to 11:00 pm'
);

/* 
 *--------------------------------------------
 Insert values for address
 *--------------------------------------------
 */

INSERT INTO address VALUES (
  1,
  '2020',
  'Busy Street',
  'Chinatown',
  'MA',
  'http://bit.ly/BytesOfChina',
  1
);

/* 
 *--------------------------------------------
 Insert values for review
 *--------------------------------------------
 */

INSERT INTO review VALUES (
  1,
  5.0,
  'Would love to host another birthday party at Bytes of China!',
  '05-22-2020',
  1
);

INSERT INTO review VALUES (
  2,
  4.5,
  'Other than a small mix-up, I would give it a 5.0!',
  '04-01-2020',
  1
);

INSERT INTO review VALUES (
  3,
  3.9,
  'A reasonable place to eat for lunch, if you are in a rush!',
  '03-15-2020',
  1
);

/* 
 *--------------------------------------------
 Insert values for category
 *--------------------------------------------
 */

INSERT INTO category VALUES (
  'C',
  'Chicken',
  null
);

INSERT INTO category VALUES (
  'LS',
  'Luncheon Specials',
  'Served with Hot and Sour Soup or Egg Drop Soup and Fried or Steamed Rice  between 11:00 am and 3:00 pm from Monday to Friday.'
);

INSERT INTO category VALUES (
  'HS',
  'House Specials',
  null
);

/* 
 *--------------------------------------------
 Insert values for dish
 *--------------------------------------------
 */

INSERT INTO dish VALUES (
  1,
  'Chicken with Broccoli',
  'Diced chicken stir-fried with succulent broccoli florets',
  false
);

INSERT INTO dish VALUES (
  2,
  'Sweet and Sour Chicken',
  'Marinated chicken with tangy sweet and sour sauce together with pineapples and green peppers',
  false
);

INSERT INTO dish VALUES (
  3,
  'Chicken Wings',
  'Finger-licking mouth-watering entree to spice up any lunch or dinner',
  true
);

INSERT INTO dish VALUES (
  4,
  'Beef with Garlic Sauce',
  'Sliced beef steak marinated in garlic sauce for that tangy flavor',
  true
);

INSERT INTO dish VALUES (
  5,
  'Fresh Mushroom with Snow Peapods and Baby Corns',
  'Colorful entree perfect for vegetarians and mushroom lovers',
  false
);

INSERT INTO dish VALUES (
  6,
  'Sesame Chicken',
  'Crispy chunks of chicken flavored with savory sesame sauce',
  false
);

INSERT INTO dish VALUES (
  7,
  'Special Minced Chicken',
  'Marinated chicken breast sauteed with colorful vegetables topped with pine nuts and shredded lettuce.',
  false
);

INSERT INTO dish VALUES (
  8,
  'Hunan Special Half & Half',
  'Shredded beef in Peking sauce and shredded chicken in garlic sauce',
  true
);

INSERT INTO categories_dishes VALUES (
  'C',
  1,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'C',
  3,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  1,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  4,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  5,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  6,
  15.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  7,
  16.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  8,
  17.95
);

-- STEP 10 Once you have successfully imported the sample data in projectdata.sql, you can start making queries to the database. The SELECT, AS, FROM, WHERE, ORDER BY, HAVING and GROUP BY keywords will be useful here as well as a couple of functions.In script.sql. Type in a query that displays the restaurant name, its address (street number and name) and telephone number. Then, click SAVE to run the query.

SELECT restaurant.name, address.street_address, address.street_name, restaurant.telephone
FROM restaurant, address;


-- STEP 11 In script.sql, write a query to get the best rating the restaurant ever received. Display the rating as best_rating. Then, click SAVE to run the query.

SELECT MAX(rating)
FROM review;


-- STEP 12 Open script.sql. Write a query to display a dish name, its price and category sorted by the dish name.

SELECT dish.name AS dish_name, categories_dishes.price, category.name AS category
FROM dish, category, categories_dishes
WHERE categories_dishes.dish_id = dish.id AND categories_dishes.category_id = category.id 
ORDER BY dish.name;

-- STEP 13 Instead of sorting the results by dish name, type in a new query to display the results as follows, sorted by category name.

SELECT category.name AS category, dish.name AS dish_name, categories_dishes.price 
FROM dish, category, categories_dishes
WHERE categories_dishes.dish_id = dish.id AND categories_dishes.category_id = category.id 
ORDER BY category;

-- STEP 14 Next, type a query in script.sql that displays all the spicy dishes, their prices and category.

SELECT dish.name AS spicy_dish_name, category.name AS category, categories_dishes.price 
FROM dish, category, categories_dishes
WHERE categories_dishes.dish_id = dish.id AND categories_dishes.category_id = category.id AND hot_and_spicy = true;

-- STEP 15 Write a query that displays the dish_id and COUNT(dish_id) as dish_count from the categories_dishes table. When we are displaying dish_id along with an aggregate function such as COUNT(), we have to also add a GROUP BY clause which includes dish_id.

SELECT dish_id, COUNT(dish_id) AS dish_count
FROM categories_dishes
GROUP BY 1 ORDER BY 1;

-- STEP 16 Great work! Try to adjust the previous query to display only the dish(es) from the categories_dishes table which appears more than once. We can use the aggregate function, COUNT() as a condition. But instead of using the WHERE clause, we use the HAVING clause together with COUNT().

SELECT dish_id, COUNT(dish_id) AS dish_count
FROM categories_dishes
GROUP BY 1 
HAVING COUNT(dish_id) > 1;

-- STEP 17 Excellent! The previous two queries only give us a dish_id which is not very informative. We should write a better query which tells us exactly the name(s) of the dish that appears more than once in the categories_dishes table. Write a query that incorporates multiple tables that display the dish name as dish_name and dish count as dish_count.

SELECT dish.name, COUNT(dish_id) AS dish_count
FROM categories_dishes, dish
WHERE dish.id = categories_dishes.dish_id
GROUP BY 1
HAVING COUNT(dish.name) > 1;

-- STEP 18 It would be better if we can also see the actual review itself. Write a query that displays the best rating as best_rating and the description too. In order to do this correctly, we need to have a nested query or subquery. We would place this query in the WHERE clause.

SELECT rating as best_rating, review as desciption
FROM review
WHERE rating = ( SELECT MAX(rating) from review);
