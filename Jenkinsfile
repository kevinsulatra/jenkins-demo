pipeline {

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git url:'https://github.com/kevinsulatra/jenkins-demo.git', branch:'helm'
      }
    }

    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "ingress-nginx.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }

  }

}
