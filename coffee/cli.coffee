fs = require 'fs'
assert = require('chai').assert
CoffeeEspressoTwoShots = require '../js/coffee-espresso-two-shots.js'

engine = new CoffeeEspressoTwoShots
filename = process.argv[2]
template = fs.readFileSync filename, 'utf8'
result = engine.render template

fs.writeFile filename + ".gen", result, (err) ->
  if err 
    console.log err
  else
    console.log "==> " + filename + ".gen generated"
