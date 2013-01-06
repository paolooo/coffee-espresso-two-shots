class SaSS
  constructor: (o)->
    o = o or {}
    @newline = o.newline or "\n"
    @coffeeStyle = ''
    @convert = (s) ->
      @lines = s.split /[\n|\r|\r\n]+/
      self = @
      @lines.forEach (v,k,a) ->
        return unless v.trim() # exit if empty
        self.coffeeStyle += self._convert v.replace /\s+$/, ''
      @coffeeStyle
    @_convert = (s) ->
      return s + @newline if @_isComment s # ignore comment
      return if @_isSelector s then @_selector s else @_property s
    @_isSelector = (s) ->
    # diff between a tag and a selector is ':[\w]+' this is a pseudo-class, otherwise, it is a css property
      return s.search(/\:\s+[\w\"\'\#\d]+/) is -1 and s.search(/\+/) is -1
    @_isComment = (s) ->
      s.search(/\/\*/) > -1
    @_selector = (s) ->
      s.replace /(\s*)(.*)$/, "$1s '$2', ->#{@newline}"
    @_property = (s) ->
      # is mixin
      if s.search(/\+/) > -1
        return "#{s.replace(/\"/g,'\'').replace(/\+/,'').replace(/\(/,' ').replace(/\$/,'').replace(/\)/,'').replace(/\-/,'_')}#{@newline}"
      else
        c = s.split ':'
        p = c[0].replace '-', '_'
        return "#{p} '#{c[1].replace(/^\s*/,'').replace /\'/g, '\"'}'#{@newline}"

exports.getSaSS = (o)->
  new SaSS(o)
