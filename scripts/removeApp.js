module.exports = function(db, ssn) {
  const sql = db.prepare('DELETE FROM Applicants WHERE social= ?')
  let info = sql.run(ssn)
}
