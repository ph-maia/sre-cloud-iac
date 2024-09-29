const core = require('@actions/core');
const fs = require('fs');

let path = core.getInput('path');
const fileWs = core.getInput('workspace');
const profile = core.getInput('profile');


async function getKey(path) {
  try {
    
    if(!path.endsWith("/")) path += "/"

    let arrayPath = path.split("/")
    let key = ""

    for (let index = 2; index < arrayPath.length - 1; index++){
      key += `${arrayPath[index]}/`
    }

    key += 'terraform.tfstate'

    return key

  }catch (err){     
     core.setFailed(err);
  };
};

getKey(path)
  .then(
    key => configureBackend(key)
  )

  async function configureBackend(key) {
    
    core.setOutput("key", key);
    core.setOutput("path", path);
    console.log(`output key: ${key}`)

    fs.appendFileSync(fileWs, `\nprofile = "${profile}"`)
    fs.appendFileSync(fileWs, `\nkey = "${key}"`)

  }