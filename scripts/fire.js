module.exports = function(db, id) {
  const sql = db.prepare('DELETE FROM Employee WHERE employee_id = ?')
  let info = sql.run(id)
}
