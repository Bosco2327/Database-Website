import sqlite3
import sys
connection = sqlite3.connect("../Practice.db")

cursor = connection.cursor()

arg = sys.argv

def hire(arg):
    combine = int(arg[2]) * int(arg[3]) % 9000 * int(arg[3])
    sub = int(arg[4]) + int(arg[2])
    info = (arg[1], combine, sub, 12062018)
    cursor.execute('INSERT INTO Employee VALUES(?, ?, ?, ?)', info)
    cursor.execute('INSERT INTO Guard VALUES(?, ?)', (combine, 25000))
    cursor.execute('INSERT INTO Guard_Shift VALUES(?, ?)', ("C", combine))
    cursor.execute('INSERT INTO Employee_Phone VALUES(?, ?)', (combine, arg[4]))
    cursor.execute('DELETE FROM Applicants WHERE social = ?', (arg[2],))


hire(arg)

connection.commit()

cursor.close()

connection.close()
