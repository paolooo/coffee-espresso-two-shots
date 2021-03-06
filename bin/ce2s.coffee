engine   = require '../js/coffee-espresso-two-shots.js'
fs       = require 'fs'
o        = {}
filename = process.argv[2]
o.debug  = false

if process.argv[3]?
  switch process.argv[3]
    when '--haml' then o.format = 'haml'
    when '--sass' then o.format = 'sass'
    when '--debug' then o.debug = true

if process.argv[4]?
  switch process.argv[4]
    when '--haml' then o.format = 'haml'
    when '--sass' then o.format = 'sass'
    when '--debug' then o.debug = true

template = fs.readFileSync filename, 'utf8'
result = engine.render template, o
fs.writeFile filename + ".gen", result, (err) ->
  return console.log err if err
  console.log "==> " + filename + ".gen generated"
