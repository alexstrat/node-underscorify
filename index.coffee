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
            try
                jst = _.template(buffer.toString()).source;
            catch e
                message = e.message + ' in '+ file
                message += '\n'
                message += e.source
                throw new Error(message)
            compiled += "module.exports = " + jst + ";\n";
            @queue(compiled)
            @queue(null)
    )

