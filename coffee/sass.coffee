class SaSS
  constructor: (o)->
    o = o or {}
    @newline = o.newline or "\n"
    @debug = o.debug or false

    @coffeeStyle = ''
    @_comment = false
    @_isPrevSelectWithComma = false
    @convert = (s) ->
      @lines = s.split /[\n|\r|\r\n]+/
      self = @
      @lines.forEach (v,k,a) ->
        return unless v.trim() # exit if empty
        self.coffeeStyle += self._convert v.replace /\s+$/, ''
      @coffeeStyle.replace /[\n|\r|\r\n]$/, ''
    @_convert = (s) ->
      s = '#'+s if o.debug
      return s.replace(/\@import\s+/,'#=require ../') + ".css.coffee#{@newline}" if @_isImport s # @import
      return s.replace(/\/+\**/,'#').replace(/\*/,'#') + @newline if @_isComment s # ignore comment
      return if @_isSelector s then @_selector s else @_property s
    @_isSelector = (s) ->
    # diff between a tag and a selector is ':[\w]+' this is a pseudo-class, otherwise, it is a css property
      return s.search(/\:\s+[\w\"\'\#\d]+/) is -1 and s.search(/\+/) is -1
    @_isImport = (s) ->
      s.search(/^@/) > -1
    @_isComment = (s) ->
      if s.search(/(\/\*+|\/\/)/) > -1
        @_comment = true
      else if s.search(/^\s*\*/) > -1 and @_comment
        @_comment = true
      else
        @_comment = false
      @_comment
    @_selector = (s) ->
      s.replace /(\s*)(.*)$/, "$1s '$2', ->#{@newline}"
    @_property = (s) ->
      # is mixin
      if s.search(/\+/) > -1
        c = s.split '('
        return "#{c[0].replace(/\+/,'').replace(/\-/g,'_')} #{c[1].replace(/\"/g,'\'').replace(/\(/,' ').replace(/\$/,'').replace(/\)/,'')}#{@newline}"
      else
        c = s.split ':'
        return "#{c[0].replace(/\-/g,'_')} '#{c[1].replace(/^\s*/,'').replace(/\'/g,'\"')}'#{@newline}"

exports.getSaSS = (o)->
  new SaSS(o)
