const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const {exec} = require('child_process')

app.use(bodyParser.urlencoded({extended: true}))


app.use('/css', express.static('css'))
app.use('/img', express.static('img'))


app.get('/', function(req,res) {
  res.sendFile(__dirname + '/html/home.html')
})

app.get('/login', function(req, res) {
  res.sendFile(__dirname + '/html/login.html')
})




app.listen(8200)
