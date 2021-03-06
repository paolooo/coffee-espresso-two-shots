// Generated by CoffeeScript 1.4.0
var SASS;

module.exports = SASS = (function() {

  function SASS(o) {
    this.o = o != null ? o : {};
    this.newline = o.newline || '\n';
    this.debug = o.debug || false;
    this.coffeeStyle = '';
    this._comment = false;
    this._isPrevSelectorWithComma = false;
  }

  SASS.prototype.convert = function(s) {
    var self;
    s = s.trim().replace(/[\r\n|\r|\n]{2}/, this.newline + '[:newline]' + this.newline).replace(/\r\n/, '');
    this.lines = s.split(/[\n]/);
    self = this;
    this.lines.forEach(function(v, k, a) {
      var r;
      if (v === '[:newline]' || v === '') {
        return self.coffeeStyle += self.debug ? '#' + self.newline : self.newline;
      } else {
        r = self._convert(v.replace(/\s+$/, ''));
        return self.coffeeStyle += self.debug ? '#' + r : r;
      }
    });
    return this.coffeeStyle.trim();
  };

  SASS.prototype._convert = function(s) {
    if (this._isImport(s)) {
      return s.replace(/\@import\s+/, '#=require ../').replace(/partials\//, 'partials\/_') + (".css.coffee" + this.newline);
    }
    if (this._isComment(s)) {
      return s.replace(/\/+\**/, '#').replace(/\*/, '#') + this.newline;
    }
    if (this._isSelector(s)) {
      return this._selector(s);
    } else {
      return this._property(s);
    }
  };

  SASS.prototype._isSelector = function(s) {
    return s.search(/\:\s+[\w\"\'\#\d\-]+/) === -1 && s.search(/\+/) === -1;
  };

  SASS.prototype._isImport = function(s) {
    return s.search(/^@/) > -1;
  };

  SASS.prototype._isComment = function(s) {
    if (s.search(/(\/\*+|\/\/)/) > -1) {
      this._comment = true;
    } else if (s.search(/^\s*\*/) > -1 && this._comment) {
      this._comment = true;
    } else {
      this._comment = false;
    }
    return this._comment;
  };

  SASS.prototype._selector = function(s) {
    var r;
    s = s.replace(/\'/g, '"');
    if (-1 < s.search(/\,$/)) {
      r = !this._isPrevSelectorWithComma ? s.replace(/(\s*)(.*)$/, "$1s '$2") : s.replace(/\s*(.*)$/, " $1");
      this._isPrevSelectorWithComma = true;
      return r;
    } else if (s === '') {
      return this.newline;
    } else {
      if (this._isPrevSelectorWithComma) {
        this._isPrevSelectorWithComma = false;
        return s.replace(/\s*(.*)$/, " $1', ->" + this.newline);
      }
      return s.replace(/(\s*)(.*)$/, "$1s '$2', ->" + this.newline);
    }
  };

  SASS.prototype._property = function(s) {
    var c;
    if (-1 < s.search(/\+/)) {
      c = s.split('(');
      return "" + (c[0].replace(/\+/, '').replace(/\-/g, '_')) + " " + (c[1].replace(/\"/g, '\'').replace(/\(/, ' ').replace(/\$/, '').replace(/\)/, '')) + this.newline;
    } else {
      c = s.split(':');
      return "" + (c[0].replace(/\-/g, '_')) + " '" + (c[1].replace(/^\s*/, '').replace(/\'/g, '\"')) + "'" + this.newline;
    }
  };

  return SASS;

})();
