module.exports = class CoffeeEspressoTwoShots
  render: (s) ->
    # identify 's' if it is a haml or sass
    format = @_inspector s
    switch format
      when 'sass' then result = @convertFromSaSS s
      when 'haml' then result = @convertFromHaml s
    result

  # identifies if param 's' is a haml or sass code
  _inspector: (s) ->
    return if -1 < s.search /%[\w]+$/ then 'haml' else 'sass'
 
  convertFromSaSS: (s) ->
    sass = require('../js/sass.js').getSaSS()
    sass.convert s
