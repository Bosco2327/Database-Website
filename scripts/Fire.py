import sqlite3
import sys
connection = sqlite3.connect("../Project.db")

cursor = connection.cursor()

arg = sys.argv

def fire(arg):
    cursor.execute('DELETE FROM Employee WHERE employee_id = ?', (arg[1],))

fire(arg)

connection.commit()

cursor.close()

connection.close()
