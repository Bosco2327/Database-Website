import sqlite3
import sys
connection = sqlite3.connect("../Project.db")

cursor = connection.cursor()

arg = sys.argv

def Login(arg):
    info = (arg[1], arg[2])
    temp = ""
    for warden in cursor.execute('SELECT * from Warden WHERE name = ? AND password = ?', info):
        temp = "warden"
    for emp in cursor.execute('SELECT * from Employee WHERE employee_id = ? AND password = ?', info):
        temp = "employee"
    if (temp == "warden"):
        print(2)
    elif(temp == "employee"):
        print(1)
    else:
        print(0)


Login(arg)

cursor.close()

connection.close()
