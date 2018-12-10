module.exports = function(db, name, id, sdate, phone, block, wname) {
  const sql1 = db.prepare('INSERT INTO Employee(employee_name, employee_id, start_date) VALUES(?, ?, ?)')

  let info1 = sql1.run(name, id, sdate)

  const sql2 = db.prepare('INSERT INTO Employee_Phone VALUES(?, ?)')

  let info2 = sql2.run(id, phone)

  const sql3 = db.prepare('INSERT INTO Guard_Shift VALUES(?, ?)')

  let info3 = sql3.run(block, id)

  const sql4 = db.prepare('INSERT INTO Guard(employee_id) VALUES(?)')

  let info4 = sql4.run(id)

  const sql5 = db.prepare('INSERT INTO Manages VALUES(?, ?)')

  let info5 = sql5.run(wname, id)
}
