
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
    // def SCM_REPO="demo"
    // def SCM_OWNER="tatroc"
    // def GIT_REPO="demo"
    // def SCM_URL="https://github.com/tatroc/${GIT_REPO}.git"
    // def GIT_CRED_ID="tatroc_gh"
    // def GIT_BRANCH="dev"
    // def MVN_URL="https://maven.pkg.github.com/tatroc/demo"



node('jenkinsAgent') {
  //triggers{pollSCM('*/1 * * * *')}
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

    stage('Initialize')
    {
      //  def dockerHome = tool 'MyDocker'
      //  def mavenHome  = tool 'MyMaven'
      //  env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"

        load "../${env.WORKSPACE}@tmp/${envr}.env.sh"
        echo "${GIT_CRED_ID}"


    }

// environment {
//     DEBIAN_FRONTEND = "noninteractive"
//     GIT_AUTHOR_NAME = "jenkins"
//     GIT_AUTHOR_EMAIL = "tss-devops@kaplan.com"
//     GIT_COMMITTER_NAME = "$GIT_AUTHOR_NAME"
// }


// environment {
//         GITHUB_CREDS = credentials("${GIT_CRED_ID}")
//         GITHUB_USERNAME = "$GITHUB_CREDS_USR"
//         GITHUB_PASSWORD = "$GITHUB_CREDS_PSW"
//         DEBIAN_FRONTEND = "noninteractive"
//         GIT_AUTHOR_NAME = "jenkins"
//         GIT_AUTHOR_EMAIL = "tss-devops@kaplan.com"
//         GIT_COMMITTER_NAME = "$GIT_AUTHOR_NAME"
//         MVN_URL = "$MVN_URL"
//         SCM_URL = "$SCM_URL"
//     }
//     script {
//         if ('1' == '1') {
//             echo "something"
//         } 
//     }


  //agent { label 'cloudops-dev' }
  //stages {


    stage ('Checkout') {
                echo "${GIT_CRED_ID}"
        sh """
    
        pwd
        ls -la
        cd ..
        ls -la
        """
    // cleanWs()
        // steps {
            // script {
        load "./${envr}.env.sh"
            // }

        dir("${SCM_REPO}") {
            checkout([$class: 'GitSCM', 
                branches: [[name: "*/${GIT_BRANCH}"]], 
                extensions: [[$class: 'LocalBranch', localBranch: "**"]],
                submoduleCfg: [],
                userRemoteConfigs: [[credentialsId: "${GIT_CRED_ID}", url: "${SCM_URL}"]]])

            sh '''
            ls -la
            git branch
            pwd
            '''
        }
        // }
    }

        stage('Prepare') {
         //   steps {
              //  script {
                    load "./${envr}.env.sh"
             //   }
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
         //   }
        }




        stage ('Build') {
        // cleanWs()
         //   steps {
              //  script {
            load "./${envr}.env.sh"
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
                    echo ${envr}
                    . ./${envr}.env.sh
                    env

                    pwd
                    #./deploy.sh
                    """
                }
            }
          //  }
        }



}


