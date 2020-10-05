var fs = require("fs");
var child_process = require("child_process");
var promisify = require("util").promisify;

joo_global_object.fs = {
  readDir: promisify(fs.readdir),
  readFile: promisify(fs.readFile),
  exists: promisify(fs.exists),
};

joo_global_object.child_process = {
  exec: child_process.exec,
  spawn: child_process.spawn,
};
