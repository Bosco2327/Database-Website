import sqlite3
import sys
connection = sqlite3.connect("../Project.db")

cursor = connection.cursor()

arg = sys.argv

def apply(arg):
    info = (arg[1], arg[2], arg[3], arg[4])
    cursor.execute('INSERT INTO Applicants VALUES(?, ?, ?, ?)', info)

apply(arg)

connection.commit()

cursor.close()

connection.close()
