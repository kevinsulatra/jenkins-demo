pipeline {
  agent {
    kubernetes {
    defaultContainer 'helm'
    yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: helm
    image: kevinsulatra/demo-helm:latest
    command:
    - sleep
    args:
    - 99d
    """
    }
  }

  stages {
    stage('Cloning Git') {
      steps {
        git url:'https://github.com/kevinsulatra/jenkins-demo.git', branch:'helm-demo'
      }
    }

    stage('Add Helm Repo') {
      steps{
        sh 'helm repo add library https://core.harbor.dev.h.fmlabs.xyz/chartrepo/library'
      }
    }

    stage('Package and push Helm chart') {
      steps{
        withCredentials([usernamePassword(credentialsId: 'Harbor', passwordVariable: 'pass', usernameVariable: 'user')]) {
          sh 'helm push --username $user --password $pass demo-chart library'
        }
      }
    }
 }
}
