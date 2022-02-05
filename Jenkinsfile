
def envr = "sbx"

// if (envr == 'sbx') {
//     def SCM_REPO="demo"
//     def SCM_OWNER="tatroc"
//     def GIT_REPO="demo"
//     def SCM_URL="https://github.com/tatroc/${GIT_REPO}.git"
//     def GIT_CRED_ID="tatroc_gh"
//     def GIT_BRANCH="dev"
//     def MVN_URL="https://maven.pkg.github.com/tatroc/demo"
// } else {
//     echo 'I execute elsewhere'
// }
def SCM_REPO="demo"
def SCM_OWNER="tatroc"
def GIT_REPO="demo"
def SCM_URL="https://github.com/tatroc/${GIT_REPO}.git"
def GIT_CRED_ID="tatroc_gh"
//def GIT_BRANCH="dev"
def MVN_URL="https://maven.pkg.github.com/tatroc/demo"



pipeline {
    agent { label 'jenkinsAgentV2' }
  //triggers{pollSCM('*/1 * * * *')}



// environment {
//     DEBIAN_FRONTEND = "noninteractive"
//     GIT_AUTHOR_NAME = "jenkins"
//     GIT_AUTHOR_EMAIL = "tss-devops@kaplan.com"
//     GIT_COMMITTER_NAME = "$GIT_AUTHOR_NAME"
// }


environment {
        GIT_CRED = credentials("${GIT_CRED_ID}")
        GIT_USERNAME = "$GIT_CRED_USR"
        GIT_PASSWORD = "$GIT_CRED_PSW"
        DEBIAN_FRONTEND = "noninteractive"
        GIT_AUTHOR_NAME = "jenkins"
        GIT_AUTHOR_EMAIL = "tss-devops@kaplan.com"
        GIT_COMMITTER_NAME = "$GIT_AUTHOR_NAME"
        MVN_URL = "$MVN_URL"
        SCM_URL = "$SCM_URL"
    }

    // script {
    //     if ('1' == '1') {
    //         echo "something"
    //     } 
    // }


  //agent { label 'cloudops-dev' }
  stages {


        stage ('Checkout') {

        // cleanWs()
            steps {
                // script {
                //     load "./${envr}.env.sh"
                // }

                dir("${SCM_REPO}") {
                    checkout([$class: 'GitSCM', 
                        branches: [[name: "*/${env.BRANCH_NAME}"]], 
                        extensions: [[$class: 'LocalBranch', localBranch: "**"]],
                        submoduleCfg: [],
                        userRemoteConfigs: [[credentialsId: "${GIT_CRED_ID}", url: "${SCM_URL}"]]])

                    sh '''
                    ls -la
                    git branch
                    pwd
                    '''

                    withCredentials([usernamePassword(credentialsId: "${GIT_CRED_ID}", usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                            sh 'git config credential.helper "/bin/bash ./credential-helper.sh"'
                            sh 'git fetch --all'
                            sh 'git branch -a'
                            sh 'git checkout master'
                            sh 'git log --oneline --pretty=format:%H'
                            sh "git checkout ${env.BRANCH_NAME}"
                    }
                }
            }
        }

        stage('Prepare') {
            steps {
                // script {
                //     load "./${envr}.env.sh"
                // }
                // environment {
                //     GITHUB_CREDS = credentials("${GIT_CRED_ID}")
                //     GITHUB_USERNAME = "$GITHUB_CREDS_USR"
                //     GITHUB_PASSWORD = "$GITHUB_CREDS_PSW"
                //     MVN_URL = "${MVN_URL}"
                //     SCM_URL = "${SCM_URL}"
                // }


                //assuming mvn-settings.xml is at root/current folder, otherwise provide absolute or relative path
                dir("${SCM_REPO}") {
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
                // script {
                //     load "./${envr}.env.sh"
                // }
                withCredentials([usernamePassword(credentialsId: "${GIT_CRED_ID}", usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_PASSWORD')]) {
                // environment {
                //     GITHUB_CREDS = credentials("${GIT_CRED_ID}")
                //     GITHUB_USERNAME = "$GITHUB_CREDS_USR"
                //     GITHUB_PASSWORD = "$GITHUB_CREDS_PSW"
                //     MVN_URL = "${MVN_URL}"
                //     SCM_URL = "${SCM_URL}"
                // }
                    dir("${SCM_REPO}") {
                        sh """
                        #!/bin/bash
                        echo ${envr}
                        #. ./${envr}.env.sh
                        env

                        pwd
                        ./deploy.sh
                        """
                    }
                }
            }
        }


  }
}


