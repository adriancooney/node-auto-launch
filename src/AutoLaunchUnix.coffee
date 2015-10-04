ini = require 'ini'
fs = require 'fs'

SYSTEMD_SERVICES_PATH = '/etc/systemd/system/'

module.exports =
    # Create the service file
    enable: (opts, cb) ->
        unit =
            Unit:
                Description: opts.appName
            Service:
                ExecStart: opts.appPath
            Install:
                WantedBy: 'multi-user.target'

        fs.writeFile @getServicePath(opts), ini.stringify(unit), cb

    # Check if the unit file exists
    isEnabled: (opts, cb) -> fs.exists @getServicePath(opts), cb

    # Delete the unit file
    disable: (opts, cb) -> fs.unlink @getServicePath(opts), cb

    # Get the path to the systemd service
    # return {string}
    getServicePath: (opts) ->
        return SYSTEMD_SERVICES_PATH + @toSlug(opts.appName) + '.service'

    # Convert a string to a slug
    # e.g. "Tommy's wonderlang" -> "tommys-wonderland"
    # str - The {string} to slugify
    # returns a {String}
    toSlug: (str) ->
        return str.replace /\s+/g, '-'
            .replace /[^a-z0-9_]/g, ''