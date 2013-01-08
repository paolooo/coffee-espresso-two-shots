class Haml
  constructor: (o) ->
    @o = o or {}
    @newline = o.newline or '\n'
    @debug = o.debug or false

    @coffeeJS = ''
    @_comment = false
    @convert = (s) ->
      @lines = s.split @newline
      self = @
      @lines.forEach (v,k,a) ->
        v = v.replace(/\s*$/, '')
        if self._isComment v
          self.coffeeJS += self.comment v
        else if self._isTag v
          self.coffeeJS += self.tag v
        else
          self.coffeeJS += self.content v
      @coffeeJS.trim()

    @_isComment = (s) ->
      s.search(/-#|^\s*\//) > -1
    @_isTag = (s) ->
      s.search(/^\s*[\.\#\%]+/ ) > -1
    @_convert = (s) ->

    @comment = (s) ->
      r = s.replace(/(^\s*)(\-\#)|(\/)/, '$1#') + @newline
      r = '#' + r if @debug
      r
    @tag = (s) ->
      _with_content = s.replace(/(\%\w+[\.\#\w]+)\{.*\}/, '$1').search(/\%\w+[\.\#]{0,1}[^\s]+\s+(.+)$/) > -1
      _with_attr = s.search(/\%\w+[\.\#\{]/) > -1
      _tag_only = s.search(/\%\w+[^\s]+$/) > -1
      _empty_tag = s.search(/\/\s*$/) > -1
      r = s.replace(/(\s*)\%(\w+)\s+(.*)$/, "$1$2 '$3'")
        .replace(/\:/g,'')
        .replace(/\s*\=>\s*/g,':')
        .replace(/(\s*\%\w+)([\.\#][^{]+)/, "$1 '$2'")
        .replace(/\}\/{0,1}\s*$/g,'')
        .replace(/\}\s*(.+)$/, ", '$1'")
        .replace(/\'\{\s*/,'\', ')
        .replace(/\{\s*/, ' ')
        .replace(/\%(\w+)/, '$1')
        .replace(/^(\s*)([\.\#])([\w\d\-\.\#\_]+)$/, "$1div '$2$3'")
      if _empty_tag
        r += @newline
      else if _with_content
        r += @newline
      else if _tag_only and _with_attr
        r += ", ->#{@newline}"
      else if _tag_only
        r += " ->#{@newline}"
      else
        r += ", ->#{@newline}"
      r = '#' + r if @debug
      r
    @content = (s) ->
      return '' if s.trim() is ''
      r = s.replace(/\"/g, '\"').replace(/^(\s*)(.*)$/,'$1text "$2"') + @newline
      r = '#' + r if @debug
      r
exports.getHaml = (o)->
  new Haml o or {}
