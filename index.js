const {SESSION_KEY} = process.env

const Database = require('better-sqlite3')
const db = new Database('./Project.db')

const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const cookieSession = require('cookie-session')
const eh = require('express-handlebars')
const login = require('./scripts/login')
const wardenlog = require('./scripts/wardenlog')

app.engine('handlebars', eh({defaultLayout: 'main'}))
app.set('view engine', 'handlebars')


app.use(cookieSession({
  name: 'session',
  keys: [SESSION_KEY]
}))

app.use(bodyParser.urlencoded({extended: true}))


app.use('/css', express.static('css'))
app.use('/js', express.static('js'))
app.use('/img', express.static('img'))

app.use(function setRenderBody(req, res, next) {
  res.renderOptions = {
    css: [
      './reset.css',
      './master.css'
    ],
    js: ['/js/master.js'],
    errors: [],
    loggedin: req.session.loggedin || false,
    warden: req.session.warden || false
  }
  if (req.session.loggedin) {
    res.renderOptions.usrid = req.session.usrid
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

function requireWarden(req, res, next) {
  if (req.session.warden) {
    return next()
  } else {
    return res.redirect('/')
  }
}

function requireNotWarden(req, res, next) {
  if (req.session.warden) {
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
  res.renderOptions.css.push('login.css')
  let id = req.body.id
  let pass = req.body.password
  try {
    let userInfo = login(db, id, pass)
    if (userInfo == null) {
      let wardenInfo = wardenlog(db, id, pass)
      if (wardenInfo == null) {
        res.renderOptions.errors.push('Invalid login information')
        return res.render('login', res.renderOptions)
      }
      req.session.usrid = id
      req.session.loggedin = true
      req.session.username = wardenInfo.name
      req.session.warden = true
      return res.redirect('/') // TODO: Make special page for warden
    }
    console.log('USERINFO', userInfo)
    req.session.usrid = id
    req.session.loggedin = true
    req.session.username = userInfo.employee_name
    req.session.warden = false
    return res.redirect('/')
  } catch (e) {
    console.log('EEEEE', e)
    res.renderOptions.errors.push('Unexpected Error Occurred')
    return res.render('login', res.renderOptions)
  }
})

app.get('/logout', requireLoggedIn, function(req, res) {
  req.session.warden = false
  req.session.loggedin = false
  req.session.username = null
  req.session.usrid = null
  res.redirect('/')
})

app.listen(5000)

process.on('exit', () => db.close())
process.on('SIGINT', () => db.close())
process.on('SIGHUP', () => db.close())
process.on('SIGTERM', () => db.close())

process.on('SIGINT', () => {
  process.exit()
});
