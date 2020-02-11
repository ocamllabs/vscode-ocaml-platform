let { promisify } = require("util");
let fs = require("fs");
let readFile = promisify(fs.readFile);
let writeFile = promisify(fs.writeFile);
let mkdir = promisify(fs.mkdir);
let exists = promisify(fs.exists);
let open = promisify(fs.open);
let write = promisify(fs.write);
let close = promisify(fs.close);
let thisProjectsEsyJson = JSON.stringify(require("../../esy.json"));
let unlink = promisify(fs.unlink);

module.exports = {
  readFile,
  writeFile,
  mkdir,
  exists,
  open,
  write,
  close,
  thisProjectsEsyJson,
  unlink
};
