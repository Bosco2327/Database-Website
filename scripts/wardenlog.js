module.exports = function(db, id, pass) {
  const sql = db.prepare('SELECT * FROM Warden WHERE id = ? AND password = ?')

  let info = sql.get(id, pass)
  return info
}
