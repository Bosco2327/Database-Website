const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const {exec} = require('child_process')

app.use(bodyParser.urlencoded({extended: true}))
