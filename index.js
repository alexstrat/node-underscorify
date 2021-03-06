// Generated by CoffeeScript 1.6.3
var through, _;

through = require('through');

_ = require("underscore");

module.exports = function(file) {
  var buffer;
  if (!/\.tpl|\.html/.test(file)) {
    return through();
  }
  buffer = "";
  return through(function(chunk) {
    return buffer += chunk.toString();
  }, function() {
    var compiled, jst;
    compiled = "_ = require('underscore');\n";
    jst = _.template(buffer.toString()).source;
    compiled += "module.exports = " + jst + ";\n";
    this.queue(compiled);
    return this.queue(null);
  });
};
