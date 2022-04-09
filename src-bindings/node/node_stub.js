var fs = require("fs");
var promisify = require("util").promisify;

joo_global_object.fs = {
  readDir: promisify(fs.readdir),
  readFile: promisify(fs.readFile),
  exists: promisify(fs.exists),
};

joo_global_object.child_process = require("child_process");

joo_global_object.path = require("path");

joo_global_object.os = require("os");

joo_global_object.net = require("net");
