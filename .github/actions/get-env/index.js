const core = require('@actions/core');

const path = core.getInput('path');
const commitMsg = core.getInput('commit_msg');
const environmentInput = core.getInput('environment');
const event = core.getInput('event');

async function filterEnvAuto() {
    console.log("filtering environment from AUTO trigger workflow")

    let environmentPath = path.split('/')[1].replace(/\s+/g, '').toLowerCase()
    let aws_profile = environmentPath

    if(environmentPath === "dev-hml"){        
        try{
            commitLength = commitMsg.split('-').length 
            aws_profile = commitMsg.split('-')[commitLength - 1].replace(/\s+/g, '').toLowerCase()

            if(!aws_profile.match(/hml|dev/i)) aws_profile = "hml"
        }
        catch{
            aws_profile = "hml"
        }
    }

    if(!aws_profile.match(/hml|dev|org|prd/i)) aws_profile = "hml"

    core.setOutput("aws_profile", aws_profile);
    core.setOutput("env_dir", environmentPath);

    getRegion(aws_profile)

}

async function filterEnvManual() {
    console.log("filtering environment from MANUAL trigger workflow")
    
    let environmentPath = path.split('/')[1].replace(/\s+/g, '').toLowerCase()
    let aws_profile = environmentPath

    if(environmentPath === "dev-hml"){        
        aws_profile = environmentInput
    }    

    core.setOutput("aws_profile", aws_profile);
    core.setOutput("env_dir", environmentPath);

    getRegion(aws_profile)

}

async function getRegion(aws_profile){
    aws_region = "us-east-1"

    if(aws_profile === "prd"){
        aws_region = "sa-east-1"
    }

    core.setOutput("aws_region", aws_region);

}

if(event != "workflow_dispatch"){
    filterEnvAuto()
} else {
    filterEnvManual()
}