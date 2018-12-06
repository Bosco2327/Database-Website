import sqlite3
import sys
connection = sqlite3.connect("../Project.db")

cursor = connection.cursor()

arg = sys.argv

def Schedule(arg):
    info = (arg[1])
    for empty in cursor.execute('SELECT * FROM Inmate WHERE prison_id = ? AND death_row_eligible = 0 AND visit = ""', (info,)):
        cursor.execute('UPDATE Inmate SET visit = 1600 WHERE prison_id = ?', (info,))
        return
    print(0)

Schedule(arg)

connection.commit()

cursor.close()

connection.close()
