import sqlite3
import sys
connection = sqlite3.connect("../Project.db")

cursor = connection.cursor()

arg = sys.argv

def New_Inmate(arg):
    info = (arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12], arg[13], arg[14])
    cursor.execute('INSERT INTO Inmate VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', info)

New_Inmate(arg)

connection.commit()

cursor.close()

connection.close()
