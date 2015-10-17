var fs, us;

fs = require('fs');

us = require('user-startup');

module.exports = {
  enable: function(opts, cb) {
    var id, log;
    id = this.toID(opts.appName);
    log = "" + (us.getFile(id)) + ".log";
    return fs.writeFile(log, "", function() {
      us.create(id, opts.appPath, [], log);
      return cb();
    });
  },
  isEnabled: function(opts, cb) {
    return fs.exists(us.getFile(this.toID(opts.appName)), cb);
  },
  disable: function(opts, cb) {
    var id;
    id = this.toID(opts.appName);
    us.remove(id);
    return fs.unlink("" + (us.getFile(id)) + ".log", cb);
  },
  toID: function(str) {
    return str.replace(/\s+/g, '-').replace(/[^a-z0-9_]/g, '');
  }
};
