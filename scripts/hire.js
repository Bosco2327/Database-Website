module.exports = function(db, name, id, sdate, phone) {
  const sql1 = db.prepare('INSERT INTO Employee(employee_name, employee_id, start_date) VALUES(?, ?, ?)')

  let info1 = sql1.run(name, id, sdate)

  const sql2 = db.prepare('INSERT INTO Employee_Phone VALUES(?, ?)')

  let info2 = sql2.run(id, phone)
}
