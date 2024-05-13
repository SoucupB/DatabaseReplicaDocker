import mysql.connector
from faker import Faker
import random
from datetime import datetime, timedelta

# Connect to MySQL database
mydb = mysql.connector.connect(
  host="172.17.0.2",
  user="root",
  password="root_password",
  database="my_database"
)

# Create Faker instance
fake = Faker()

# Function to insert fake users
def insert_fake_users(num_users):
    cursor = mydb.cursor()
    for _ in range(num_users):
        username = fake.user_name()
        email = fake.email()
        sql = "INSERT INTO users (username, email) VALUES (%s, %s)"
        val = (username, email)
        cursor.execute(sql, val)
    mydb.commit()
    print(f"{num_users} fake users inserted successfully.")

# Function to insert fake products
def insert_fake_products(num_products):
    cursor = mydb.cursor()
    for _ in range(num_products):
        name = fake.word()
        price = round(random.uniform(10, 1000), 2)
        description = fake.text()
        sql = "INSERT INTO products (name, price, description) VALUES (%s, %s, %s)"
        val = (name, price, description)
        cursor.execute(sql, val)
    mydb.commit()
    print(f"{num_products} fake products inserted successfully.")

# Function to insert fake orders
def insert_fake_orders(num_orders):
    cursor = mydb.cursor()
    cursor.execute("SELECT id FROM users")
    user_ids = [row[0] for row in cursor.fetchall()]
    cursor.execute("SELECT id FROM products")
    product_ids = [row[0] for row in cursor.fetchall()]
    for _ in range(num_orders):
        user_id = random.choice(user_ids)
        product_id = random.choice(product_ids)
        quantity = random.randint(1, 10)
        created_at = fake.date_time_between(start_date='-1y', end_date='now')
        sql = "INSERT INTO orders (user_id, product_id, quantity, created_at) VALUES (%s, %s, %s, %s)"
        val = (user_id, product_id, quantity, created_at)
        cursor.execute(sql, val)
    mydb.commit()
    print(f"{num_orders} fake orders inserted successfully.")

# Number of fake data to insert
num_fake_users = 10
num_fake_products = 20
num_fake_orders = 50

# Insert fake data
insert_fake_users(num_fake_users)
insert_fake_products(num_fake_products)
insert_fake_orders(num_fake_orders)

# Close connection
mydb.close()