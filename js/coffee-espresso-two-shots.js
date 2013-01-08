// Generated by CoffeeScript 1.4.0
(function() {
  var CoffeeEspressoTwoShots;

  CoffeeEspressoTwoShots = (function() {

    function CoffeeEspressoTwoShots() {
      this.render = function(s, o) {
        var format, result;
        this.o = o || {};
        format = this.o.format || this._inspector(s);
        switch (format) {
          case 'sass':
            result = this.convertFromSaSS(s);
            break;
          case 'haml':
            result = this.convertFromHaml(s);
        }
        return result;
      };
      this._inspector = function(s) {
        if (-1 < s.search(/%[\w]+$/)) {
          return 'haml';
        } else {
          return 'sass';
        }
      };
      this.convertFromSaSS = function(s) {
        var sass;
        sass = require('../js/sass.js').getSaSS(this.o);
        return sass.convert(s);
      };
      this.convertFromHaml = function(s) {
        var haml;
        haml = require('../js/haml.js').getHaml(this.o);
        return haml.convert(s);
      };
    }

    return CoffeeEspressoTwoShots;

  })();

  exports.getCoffeeEspressoTwoShots = function() {
    return new CoffeeEspressoTwoShots;
  };

}).call(this);
