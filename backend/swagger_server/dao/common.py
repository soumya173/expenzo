from doctest import Example
from unittest import result
import mysql.connector

def connect_db():
    try:
        connection = mysql.connector.connect(host='localhost', port=3306, database='expenzo', user='root', password='')
        cursor = connection.cursor()
    except Exception as e:
        pass
    # cursor.execute("SELECT * FROM users;")
    # result = cursor.fetchall()
    # print(result)
    # cursor.close()
    # connection.close()
