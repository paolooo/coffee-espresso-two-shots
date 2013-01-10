module.exports = class CoffeeEspressoTwoShots
  @render: (s, o={}) ->
    # auto-detect whether given string contains Haml or SASS
    format = o.format || if -1 < s.search /%[\w]+$/ then 'haml' else 'sass'
    C = require './'+format
    (new C o).convert s
