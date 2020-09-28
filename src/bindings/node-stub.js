var promisify = require("util").promisify;
var fs = require("fs");
var child_process = require("child_process");

joo_global_object.setEnv = function (key, value) {
  process.env[key] = value;
};

joo_global_object.readDir = promisify(fs.readdir);
joo_global_object.readFile = promisify(fs.readFile);
joo_global_object.exists = promisify(fs.exists);

joo_global_object.exec = child_process.exec;
joo_global_object.spawn = child_process.spawn;
