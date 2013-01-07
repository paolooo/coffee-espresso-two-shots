fs = require 'fs'
assert = require('chai').assert
engine = require('../js/coffee-espresso-two-shots.js').getCoffeeEspressoTwoShots()

o = {}
filename = process.argv[2]
o.debug = true if process.argv[3]? and process.argv[3] is '--debug'

template = fs.readFileSync filename, 'utf8'
result = engine.render template, o
fs.writeFile filename + ".gen", result, (err) ->
  if err
    console.log err
  else
    console.log "==> " + filename + ".gen generated"
