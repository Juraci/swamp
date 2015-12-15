var HIGHLIGHT = (function(){
  var boxShadow = "0 0 15px rgba(81, 250, 200, 1)";
  var border = "1px solid rgba(81, 250, 200, 1)";

  return {
    glow: function(element) {
      element.style.boxShadow = boxShadow;
      element.style.border = border;
    }
  };
})();

module.exports = HIGHLIGHT;
