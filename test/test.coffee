fs = require 'fs'
assert = require('chai').assert
CoffeeEspressoTwoShots = require('../js/coffee-espresso-two-shots.js').getCoffeeEspressoTwoShots()

engine = output = template = null
describe 'Coffee Espresso Two Shots', ->
  before ->
    engine = CoffeeEspressoTwoShots
  beforeEach ->
    template = output = ""
    
  describe 'SaSS test', ->
    afterEach ->
      result = engine.render template
      assert.equal result, output, 'ok'

    it 'can convert simple sass code, without mixins', ->
      template = """
body
  border: 1px solid
  font-family: 'WhitneyMedium', georgia, sans-serif
  font-size: 100%
  #wrapper
    background-color: #F00

    .container
      table
        th:first, td
          border-bottom: 1px solid #F00
      """
      output = """
s 'body', ->
  border '1px solid'
  font_family '"WhitneyMedium", georgia, sans-serif'
  font_size '100%'
  s '#wrapper', ->
    background_color '#F00'

    s '.container', ->
      s 'table', ->
        s 'th:first, td', ->
          border_bottom '1px solid #F00'
      """

    it 'can convert mixin', ->
      template = """
body.users_dashboard #stage.module-08
  .slide
    +sprite-bg($general, 'bg-blank-slide')
    height: 400px
    background: url('modules/07/bg-slide-06.png') 0 0 no-repeat
      """
      output = """
s 'body.users_dashboard #stage.module-08', ->
  s '.slide', ->
    sprite_bg general, 'bg-blank-slide'
    height '400px'
    background 'url("modules/07/bg-slide-06.png") 0 0 no-repeat'
      """

    it 'can ignore this types ("/* and //") comments only', ->
      # TODO:
      # /* several lines long.
      #  * since it uses the CSS comment syntax
      # * it will appear in the CSS output.
      template = """
// comment 2
/* comment 3
      """
      output = """
# comment 2
# comment 3
      """

    it 'can convert @import', ->
      template = """
@import partials/globals
      """
      output = """
#=require ../partials/_globals.css.coffee
      """

    it 'can convert multi-line selector format', ->
      template = """
body.users_dashboard .module-07,
body.users_dashboard .module-07 table,
body.users_dashboard .module-07 th
  font-size: 13px
      """
      output = """
s 'body.users_dashboard .module-07, body.users_dashboard .module-07 table, body.users_dashboard .module-07 th', ->
  font_size '13px'
      """

    it 'convert margin-top and attribute', ->
      template = """
label
  margin-top: -15px
  font-style: normal
  &[for='m7-32-txt-reps']
    margin-top: 9px
      """
      output = """
s 'label', ->
  margin_top '-15px'
  font_style 'normal'
  s '&[for="m7-32-txt-reps"]', ->
    margin_top '9px'
      """
