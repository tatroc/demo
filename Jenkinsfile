
def envr = "sbx"

if (envr == 'sbx') {
    def SCM_REPO="demo"
    def SCM_OWNER="tatroc"
    def GIT_REPO="demo"
    def SCM_URL="https://github.com/tatroc/${GIT_REPO}.git"
    def GIT_CRED_ID="tatroc_gh"
    def GIT_BRANCH="dev"
    def MVN_URL="https://maven.pkg.github.com/tatroc/demo"
} else {
    echo 'I execute elsewhere'
}




pipeline {
  //triggers{pollSCM('*/1 * * * *')}
  agent { label 'cloudops-dev' }
  environment {
    GITHUB_CREDS = credentials("${GIT_CRED_ID}")
    GITHUB_USERNAME = "$GITHUB_CREDS_USR"
    GITHUB_PASSWORD = "$GITHUB_CREDS_PSW"
    DEBIAN_FRONTEND = "noninteractive"
    GIT_AUTHOR_NAME = "jenkins"
    GIT_AUTHOR_EMAIL = "tss-devops@kaplan.com"
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
                    ./prepare.sh
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
                    env
                    pwd
                    ./deploy.sh
                    '''
                }
            }
        }


  }
}


