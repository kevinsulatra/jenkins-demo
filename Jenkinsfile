pipeline {
  environment {
    registry = "kevinsulatra/pipeline-demo"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git url:'https://github.com/kevinsulatra/jenkins-demo.git', branch:'docker-demo'
      }
    }
    stage('Building image') {
      steps{
        container('docker'){
          script {
            dockerImage = docker.build registry + ":$BUILD_NUMBER"
          }
        }
      }
    }
    stage('Deploy Image') {
      steps{
        container('docker'){
          script {
            docker.withRegistry( '', registryCredential ) {
              dockerImage.push()
            }
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        container('docker'){
          sh "docker rmi $registry:$BUILD_NUMBER"
        }
      }
    }
  }
}
