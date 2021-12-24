pipeline {
  agent { label 'cloudops-dev' }
  environment {
    GITHUB_CREDS = credentials('tatroc_gh')
    GITHUB_USERNAME = "$GITHUB_CREDS_USR"
    GITHUB_PASSWORD = "$GITHUB_CREDS_PSW"
    DEBIAN_FRONTEND = "noninteractive"
  }
  stages {

    stage('Prepare') {
      steps {
          //assuming mvn-settings.xml is at root/current folder, otherwise provide absolute or relative path
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

    stage ('Checkout') {
       // cleanWs()
       steps {

            dir('demo') {
                checkout([$class: 'GitSCM', 
                    branches: [[name: '*/dev']], 
                    extensions: [[$class: 'LocalBranch', localBranch: "**"]],
                    submoduleCfg: [],
                    userRemoteConfigs: [[credentialsId: 'tatroc_gh', url: 'https://github.com/tatroc/demo.git']]])

                sh '''
                ls -la
                git branch
                pwd
                '''
            }

       }
    }


    stage ('Build') {
       // cleanWs()
       steps {
         dir('demo') {
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