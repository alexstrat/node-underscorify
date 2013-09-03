through = require('through')
_ = require("underscore")


module.exports = (file) ->
    return through() if (!/\.ejs/.test(file))
    buffer = ""

    return through(
        (chunk) ->
            buffer += chunk.toString()
    ,
        () ->
            compiled = "";
            jst = _.template(buffer.toString()).source;
            compiled += "module.exports = " + jst + ";\n";
            @queue(compiled)
            @queue(null)
    )

