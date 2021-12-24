pipeline {
  agent { label 'cloudops-dev' }
  environment {
    GITHUB_CREDS = credentials('tatroc_gh')
    GITHUB_USERNAME = "$GITHUB_CREDS_USR"
    GITHUB_PASSWORD = "$GITHUB_CREDS_PSW"
    DEBIAN_FRONTEND = "noninteractive"
  }
  stages {

    stage('Build') {
      steps {
          //assuming mvn-settings.xml is at root/current folder, otherwise provide absolute or relative path
          sh '''mkdir -p ~/.m2
          ls -la ~
          cp ./mvn-settings.xml ~/.m2/settings.xml
          env
          #cat ~/.m2/settings.xml
          #cat /etc/os-release
          #id
          apt update
          apt install -y maven
          mvn -v
          git log --pretty="%D %H" --decorate=short --decorate-refs=refs/tags
          git branch
          '''


      }
    }

  }
}