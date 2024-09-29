const core = require('@actions/core');
const util = require('util');
const fs = require('fs');
const exec = util.promisify(require('child_process').exec);

var currentCommit = core.getInput('current_commit');
var commitMsg = core.getInput('commit_msg');

console.log(`Inputs: currentCommit - ${currentCommit}`);

async function getPath() {
  try {

      let { stdout } = await exec(`git diff-tree --no-commit-id --name-only -r -c ${currentCommit}`);
      
      if(!Boolean(stdout)){
        console.error(`Nothing return from git diff-tree command at commit: ${currentCommit}`)
        core.setFailed(`Nothing return from git diff-tree command at commit: ${currentCommit}`);
      }

      console.log("Files that have changed:\n" + stdout);

      arrayPath = stdout.split("\n")
      arrayPath.pop()      

      return arrayPath

  }catch (err){
     console.error(err);
     core.setFailed(err);
  };
};

getPath()
  .then(
    arrayPath => setOutput(arrayPath)
  ).catch(
    err => core.setFailed("error: " + err)
  )

  async function setOutput(arrayPath) {

    let continueRun = false;

    let objPath = {};
    objPath['path'] = [];
  
    commitLength = commitMsg.split('-').length
    filterMsg = commitMsg.split('-')[commitLength - 1].replace(/\s+/g, '').toLowerCase()
  
    console.log(filterMsg)
  
    if(!filterMsg.includes("run")){    
      
      const promises = arrayPath.map(async (item) => {
  
        let lastSlash = item.lastIndexOf("/");
        let path = `${item.substring(0, lastSlash + 1)}`
      
        if((fs.existsSync(`${path}main.tf`) || item.includes("api-gtw"))) {     
  
          if(item.includes("api-gtw") && !fs.existsSync(`${path}main.tf`)){
            let pathArray = path.split('/')
            let indexOf = pathArray.indexOf("api-gtw")
  
            for(let i = indexOf; i < pathArray.length; i++){
              lastSlash.pop()
            }
  
            path = `${lastSlash.join('/')}/`
  
          }
  
          if(!objPath['path'].includes(path)){
            objPath['path'].push(path)
          }
  
        }         
  
      });
  
      await Promise.all(promises)          
          .catch(err => core.setFailed("error: " + err))
  
    }
    else {
      core.setFailed("Dont Run automatically")
    }

    if(objPath['path'].length > 0) continueRun = true
  
    core.setOutput("path", JSON.stringify(objPath));
    core.setOutput("continue", continueRun);
    
    console.log(`output path: ${JSON.stringify(objPath)}`)

    let statusNextJob = continueRun == true ? 'Continue to next job!' : 'Do not continue to next job!'
    console.log(statusNextJob)
  
  }