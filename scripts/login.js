
module.exports = function(db, id, pass) {
  const sql = db.prepare('SELECT * FROM Employee WHERE employee_id = ? AND password = ?')

  let info = sql.get(id, pass)
  return info
}

process.on('beforeExit', function() {
  db.close()
})
