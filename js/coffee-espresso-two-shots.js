// Generated by CoffeeScript 1.4.0
var CoffeeEspressoTwoShots;

module.exports = CoffeeEspressoTwoShots = (function() {

  function CoffeeEspressoTwoShots() {}

  CoffeeEspressoTwoShots.render = function(s, o) {
    var C, format;
    if (o == null) {
      o = {};
    }
    format = o.format || (-1 < s.search(/%[\w]+$/) ? 'haml' : 'sass');
    C = require('./' + format);
    return (new C(o)).convert(s);
  };

  return CoffeeEspressoTwoShots;

})();
