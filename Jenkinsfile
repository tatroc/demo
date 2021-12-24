def GIT_REPO="demo"
def GIT_URL="https://github.com/tatroc/${GIT_REPO}.git"
def GIT_CRED_ID="tatroc_gh"

pipeline {
  agent { label 'cloudops-dev' }
  environment {
    GITHUB_CREDS = credentials(GIT_CRED_ID)
    GITHUB_USERNAME = "$GITHUB_CREDS_USR"
    GITHUB_PASSWORD = "$GITHUB_CREDS_PSW"
    DEBIAN_FRONTEND = "noninteractive"
  }
  stages {


    stage ('Checkout') {
       // cleanWs()
       steps {

            dir(GIT_REPO) {
                checkout([$class: 'GitSCM', 
                    branches: [[name: '*/dev']], 
                    extensions: [[$class: 'LocalBranch', localBranch: "**"]],
                    submoduleCfg: [],
                    userRemoteConfigs: [[credentialsId: GIT_CRED_ID, url: GIT_URL]]])

                sh '''
                ls -la
                git branch
                pwd
                '''
            }

       }
    }

    stage('Prepare') {
      steps {
          //assuming mvn-settings.xml is at root/current folder, otherwise provide absolute or relative path
          dir(GIT_REPO) {
            sh '''
            #!/bin/bash
            mkdir -p ~/.m2
            #ls -la ~
            cp ./mvn-settings.xml ~/.m2/settings.xml
            #env
            #cat ~/.m2/settings.xml
            #cat /etc/os-release
            #id
            dpkg -s maven || EXIT_CODE=$?
            if [ $EXIT_CODE -eq 1 ]; then
                apt update
                apt install -y maven
            fi

            mvn -v
            #git log --pretty="%D %H" --decorate=short --decorate-refs=refs/tags
            #git branch
            '''
          }
      }
    }




    stage ('Build') {
       // cleanWs()
       steps {
            dir(GIT_REPO) {
                sh '''
                
                pwd
                '''
            }
       }
    }


  }
}




    // stage ('Checkout') {
    //    // cleanWs()
    //    steps {
    //     checkout([$class: 'SubversionSCM', 
    //     additionalCredentials: [], 
    //     excludedCommitMessages: '', 
    //     excludedRegions: '', 
    //     excludedRevprop: '', 
    //     excludedUsers: '', 
    //     filterChangelog: false, 
    //     ignoreDirPropChanges: false, 
    //     includedRegions: '', 
    //     locations: [[cancelProcessOnExternalsFail: true, 
    //     credentialsId: '234243-45654-234randomstuff', 
    //     depthOption: 'infinity', 
    //     ignoreExternalsOption: true, 
    //     local: '.', 
    //     remote: 'https://starkindustries/ironman/superGlueForThanosFingers/repo']],
    //     quietOperation: true, 
    //     workspaceUpdater: [$class: 'UpdateUpdater']])
    //    }
    // }