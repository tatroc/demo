def GIT_REPO="demo"
def SCM_URL="https://github.com/tatroc/${GIT_REPO}.git"
def GIT_CRED_ID="tatroc_gh"
def GIT_BRANCH="dev"
def MVN_URL="https://maven.pkg.github.com/tatroc/demo"

pipeline {
  //triggers{pollSCM('*/1 * * * *')}
  agent { label 'cloudops-dev' }
  environment {
    GITHUB_CREDS = credentials("${GIT_CRED_ID}")
    GITHUB_USERNAME = "$GITHUB_CREDS_USR"
    GITHUB_PASSWORD = "$GITHUB_CREDS_PSW"
    DEBIAN_FRONTEND = "noninteractive"
    GIT_AUTHOR_NAME = "jenkins"
    GIT_COMMITTER_NAME = "$GIT_AUTHOR_NAME"
    MVN_URL = "$MVN_URL"
    SCM_URL = "$SCM_URL"
  }
  stages {

        stage ('Checkout') {
        // cleanWs()
            steps {
                dir(GIT_REPO) {
                    checkout([$class: 'GitSCM', 
                        branches: [[name: "*/${GIT_BRANCH}"]], 
                        extensions: [[$class: 'LocalBranch', localBranch: "**"]],
                        submoduleCfg: [],
                        userRemoteConfigs: [[credentialsId: GIT_CRED_ID, url: SCM_URL]]])

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
                    #!/bin/bash
                    pwd
                    ./deploy.sh
                    '''
                }
            }
        }


  }
}


