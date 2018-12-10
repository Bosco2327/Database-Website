module.exports = function(db, id, block) {
  const sql = db.prepare('UPDATE Guard_Shift SET block_letter=? WHERE employee_id=?')

  let info = sql.run(block, id)
  return info
}
