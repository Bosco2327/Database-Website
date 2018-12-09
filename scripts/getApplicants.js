module.exports = function(db) {
  const sql = db.prepare('SELECT * FROM Applicants')

  let info = sql.all()
  return info
}
