pipeline {
  agent any

  stages {
    stage('Cloning Git') {
      steps {
        git url:'https://github.com/kevinsulatra/jenkins-demo.git', branch:'helm-demo'
      }
    }
    stage('Add Helm repo'){
      steps {
        sh "helm repo add library https://core.harbor.dev.h.fmlabs.xyz/chartrepo/library"
      }
    }
    stage('Push Helm Chart'){
      steps {
        sh "helm push demo-chart library"
      }
    }
  }
