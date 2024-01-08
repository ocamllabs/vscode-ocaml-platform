const fs = require("node:fs");
const { promisify } = require("node:util");

joo_global_object.fs = {
  readDir: promisify(fs.readdir),
  readFile: promisify(fs.readFile),
  exists: promisify(fs.exists),
};

joo_global_object.child_process = require("node:child_process");

joo_global_object.path = require("node:path");

joo_global_object.os = require("node:os");

joo_global_object.net = require("node:net");
