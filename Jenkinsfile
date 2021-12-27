
def envr = "sbx"




node('jenkinsAgentV2') {
  //triggers{pollSCM('*/1 * * * *')}
  checkout scm


  load "${env.WORKSPACE}/${envr}.env.sh"
  println("My SCM: " + "${SCM_REPO}")
//    if (envr == 'sbx') {

//echo "${env.DEBIAN_FRONTEND}"
// echo 'set env vars'
//          SCM_REPO="demo"
//          SCM_OWNER="tatroc"
//         // def GIT_REPO="demo"
//          SCM_URL="https://github.com/tatroc/${SCM_REPO}.git"
//          GIT_CRED_ID="tatroc_gh"
//          GIT_BRANCH="dev"
//         // def MVN_URL="https://maven.pkg.github.com/tatroc/demo"
//     } else {
//         echo 'I execute elsewhere'
//     }

    stage('Initialize')
    {

    }

    stage ('Checkout') {

        dir("${SCM_REPO}") {
            checkout([$class: 'GitSCM', 
                branches: [[name: "*/${GIT_BRANCH}"]], 
                extensions: [[$class: 'LocalBranch', localBranch: "**"]],
                submoduleCfg: [],
                userRemoteConfigs: [[credentialsId: "${GIT_CRED_ID}", url: "${SCM_URL}"]]])

        }

    }

    stage('Prepare') {
        //   steps {
            //  script {
            //     load "./${envr}.env.sh"
            //   }
            // environment {
            //     GITHUB_CREDS = credentials("${GIT_CRED_ID}")
            //     GITHUB_USERNAME = "$GITHUB_CREDS_USR"
            //     GITHUB_PASSWORD = "$GITHUB_CREDS_PSW"
            //     MVN_URL = "${MVN_URL}"
            //     SCM_URL = "${SCM_URL}"
            // }
            withCredentials([usernamePassword(credentialsId: "${GIT_CRED_ID}", usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_PASSWORD')]) {

                //assuming mvn-settings.xml is at root/current folder, otherwise provide absolute or relative path
                dir("${SCM_REPO}") {
                    sh """
                    #!/bin/bash
                    set -a
                    . ./${envr}.env.sh
                    ./prepare.sh
                    """
                }

            }
        //   }
    }

    stage ('Build') {
    // cleanWs()
        //   steps {
            //  script {
        //load "./${envr}.env.sh"
        //   }
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
                set -a
                . ./${envr}.env.sh
                ./deploy.sh
                """
            }
        }
        //  }
    }

    stage ('Cleanup') {
        cleanWs disableDeferredWipeout: true, deleteDirs: true
    }

}


