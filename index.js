const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const {exec} = require('child_process')

app.use(bodyParser.urlencoded({extended: true}))


app.use('/css', express.static('css'))


app.get('/', function(req,res) {
  res.sendFile(__dirname + '/html/home.html')
})




app.listen(8200)
