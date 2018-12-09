module.exports = function(db) {
  const sql = db.prepare('SELECT * FROM Employee')

  let info = sql.all()
  return info
}
