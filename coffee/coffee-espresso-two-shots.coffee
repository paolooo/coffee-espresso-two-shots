class CoffeeEspressoTwoShots
  constructor: ->
    @render = (s, o) ->
      # identify 's' if it is a haml or sass
      @o = o or {}
      # o.format = "sass|haml"
      format = @o.format || @_inspector s
      switch format
        when 'sass' then result = @convertFromSaSS s
        when 'haml' then result = @convertFromHaml s
      result

    # identifies if param 's' is a haml or sass code
    @_inspector = (s) ->
      return if -1 < s.search /%[\w]+$/ then 'haml' else 'sass'
   
    @convertFromSaSS = (s) ->
      sass = require('../js/sass.js').getSaSS @o
      sass.convert s

    @convertFromHaml = (s) ->
      haml = require('../js/haml.js').getHaml @o
      haml.convert s

exports.getCoffeeEspressoTwoShots = ->
  new CoffeeEspressoTwoShots
