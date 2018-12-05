const {SESSION_KEY} = process.env


const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const {exec} = require('child_process')
const cookieSession = require('cookie-session')
const eh = require('express-handlebars')

app.engine('handlebars', eh({defaultLayout: 'main'}))
app.set('view engine', 'handlebars')


app.use(cookieSession({
  name: 'session',
  keys: [SESSION_KEY]
}))

app.use(bodyParser.urlencoded({extended: true}))


app.use('/css', express.static('css'))
app.use('/img', express.static('img'))

app.use(function setRenderBody(req, res, next) {
  res.renderOptions = {
    css: [],
    errors: [],
    loggedin: req.session.loggedin
  }
  if (req.session.loggedin) {
    res.renderOptions.userid = req.session.usrid
    res.renderOptions.username = req.session.username
  }
  return next()
})

function requireLoggedIn(req, res, next) {
  if (req.session.loggedin) {
    return next()
  } else {
    return res.redirect('/')
  }
}

function requireLoggedOut(req, res, next) {
  if (req.session.loggedin) {
    return res.redirect('/')
  } else {
    return next()
  }
}

app.get('/', function(req,res) {
  res.renderOptions.css.push('home.css')
  res.render('home', res.renderOptions)
})

app.get('/login', requireLoggedOut, function(req, res) {
  res.renderOptions.css.push('login.css')
  res.render('login', res.renderOptions)
})

app.post('/login', requireLoggedOut, function(req, res) {
  let id = req.body.id
  let pass = req.body.password
  // TODO: Check login info
  res.renderOptions.errors.push('Invalid Login')
  res.renderOptions.css.push('login.css')
  res.render('login', res.renderOptions)
})

app.get('/logout', requireLoggedIn, function(req, res) {
  req.session.loggedin = false
  req.session.usrid = null
  res.redirect('/')
})




app.listen(8200)
