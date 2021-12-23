pipeline {
  agent { label 'cloudops-dev' }
  environment {
    GITHUB_CREDS = credentials('tatroc')
    GITHUB_USERNAME = "$GITHUB_CREDS_USR"
    GITHUB_PASSWORD = "$GITHUB_CREDS_PSW"
  }
  stages {

    stage('Build') {
      steps {
          //assuming mvn-settings.xml is at root/current folder, otherwise provide absolute or relative path
          sh 'mkdir -p ~/.m2'
          sh 'ls -la'
      }
    }

  }
}