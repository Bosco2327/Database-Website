module.exports = function(db) {
  const sql1 = db.prepare('SELECT SUM(salary) AS salsum FROM Guard')
  let info1 = sql1.get()

  const sql2 = db.prepare('SELECT SUM(salary) AS salsum FROM Cook')
  let info2 = sql2.get()

  const sql3 = db.prepare('SELECT salary FROM Warden')
  let info3 = sql3.get()


  var budget = info1.salsum + info2.salsum + info3.salary
  return budget
}
