module.exports = function(db, name, id) {
  const sql = db.prepare('UPDATE Inmate SET visitor=? WHERE prison_id=?')
  let info = sql.run(name, id)
}
