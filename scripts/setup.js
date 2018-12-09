
module.exports = function(db, social) {
  const sql = db.prepare('SELECT * FROM Applicants WHERE social = ?')

  let info = sql.get(social)
  return info
}
