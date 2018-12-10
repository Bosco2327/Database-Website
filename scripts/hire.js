module.exports = function(db, name, id, sdate, phone, block) {
  const sql1 = db.prepare('INSERT INTO Employee(employee_name, employee_id, start_date) VALUES(?, ?, ?)')

  let info1 = sql1.run(name, id, sdate)

  const sql2 = db.prepare('INSERT INTO Employee_Phone VALUES(?, ?)')

  let info2 = sql2.run(id, phone)

  const sql3 = db.prepare('INSERT INTO Guard_Shift VALUES(?, ?)')

  let info3 = sql3.run(block, id)
}
