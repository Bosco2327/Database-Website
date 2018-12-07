
module.exports = function(db, name, ssn, age, phone) {
  const sql = db.prepare('INSERT INTO Applicants VALUES(?, ?, ?, ?)')

  let info = sql.run(name, ssn, age, phone)
  return info
}
