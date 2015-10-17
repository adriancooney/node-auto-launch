fs = require 'fs'
us = require 'user-startup'

module.exports =
    # Create the service file
    enable: (opts, cb) ->
        id = @toID(opts.appName)
        log = "#{us.getFile(id)}.log"

        # To account for the odd API design, we need to create a log file
        # for the startup command to output to.
        fs.writeFile log, "", ->
            # And create the log file (synchronous)
            us.create id, opts.appPath, [], log

            cb()

    # Check if the unit file exists
    isEnabled: (opts, cb) ->
        return fs.exists us.getFile(@toID(opts.appName)), cb

    # Delete the unit file
    disable: (opts, cb) ->
        id = @toID(opts.appName)

        # The user-startup API (synchronous)
        us.remove id

        # Delete the log file
        fs.unlink "#{us.getFile(id)}.log", cb

    # Hash an appName
    # str - The apps {String} name
    toID: (str) ->
        return str.replace /\s+/g, '-'
            .replace /[^a-z0-9_]/g, ''