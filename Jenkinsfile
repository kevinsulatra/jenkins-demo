pipeline {
  environment {
    registry = "kevinsulatra/pipeline-demo"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent {
    docker { image 'node:14-alpine' }
    }
  stages {
    stage('Cloning Git') {
      steps {
        git url:'https://github.com/kevinsulatra/jenkins-demo.git', branch:'docker-demo'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
