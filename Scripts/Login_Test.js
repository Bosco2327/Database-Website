const sqlite3 = require('sqlite3').verbose();

let db = new sqlite3.Database('../Project.db', (err) => {
  if (err) {
    console.error(err.message);
  }
  console.log('Connected to the database.');
});

function Login(arg1, arg2)
{
    let info = (arg[1], arg[2]);
    temp = 0;
    temp = 'SELECT * from Warden WHERE name = ? AND password = ?';
    let name = arg1, password = arg2;
    if (temp){
      return (2, temp);
    }
    temp = 'SELECT * from Employee WHERE employee_id = ? AND password = ?';
    let employee_id = arg1, password = arg2;
    if (temp){
      return (1, temp);
    }
    return (0, 0);
}

db.close((err) => {
  if (err) {
    console.error(err.message);
  }
  console.log('Close the database connection.');
});
