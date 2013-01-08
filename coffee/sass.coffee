class SaSS
  constructor: (o)->
    o = o or {}
    @newline = o.newline or '\n'
    @debug = o.debug or false

    @coffeeStyle = ''
    @_comment = false
    @_isPrevSelectorWithComma = false
    @convert = (s) ->
      s = s.trim().replace(/[\r\n|\r|\n]{2}/, @newline+'[:newline]'+@newline).replace(/\r\n/,'')
      @lines = s.split /[\n]/
      self = @
      @lines.forEach (v,k,a) ->
        if v is '[:newline]' or v is ''
          self.coffeeStyle += if self.debug then '#' + self.newline else self.newline
        else
          r = self._convert v.replace /\s+$/, ''
          self.coffeeStyle += if self.debug then '#' + r else r
      @coffeeStyle.trim()
    @_convert = (s) ->
      return s.replace(/\@import\s+/,'#=require ../').replace(/partials\//, 'partials\/_') + ".css.coffee#{@newline}" if @_isImport s # @import
      return s.replace(/\/+\**/,'#').replace(/\*/,'#') + @newline if @_isComment s # ignore comment
      return if @_isSelector s then @_selector s else @_property s
    @_isSelector = (s) ->
    # diff between a tag and a selector is ':[\w]+' this is a pseudo-class, otherwise, it is a css property
      return s.search(/\:\s+[\w\"\'\#\d\-]+/) is -1 and s.search(/\+/) is -1
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
      s = s.replace /\'/g, '"'
      if -1 < s.search /\,$/
        r = unless @_isPrevSelectorWithComma then s.replace /(\s*)(.*)$/, "$1s '$2" else s.replace /\s*(.*)$/, " $1"
        @_isPrevSelectorWithComma = true
        r
      else if s is ''
        return @newline
      else
        if @_isPrevSelectorWithComma
          @_isPrevSelectorWithComma = false
          return s.replace /\s*(.*)$/, " $1', ->#{@newline}"
        return s.replace /(\s*)(.*)$/, "$1s '$2', ->#{@newline}"
    @_property = (s) ->
      # is mixin
      if -1 < s.search(/\+/)
        c = s.split '('
        return "#{c[0].replace(/\+/,'').replace(/\-/g,'_')} #{c[1].replace(/\"/g,'\'').replace(/\(/,' ').replace(/\$/,'').replace(/\)/,'')}#{@newline}"
      else
        c = s.split ':'
        return "#{c[0].replace(/\-/g,'_')} '#{c[1].replace(/^\s*/,'').replace(/\'/g,'\"')}'#{@newline}"

exports.getSaSS = (o)->
  new SaSS o or {}
