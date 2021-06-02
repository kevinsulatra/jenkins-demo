pipeline {
  agent any

  stages {
    stage('Cloning Git') {
      steps {
        git url:'https://github.com/kevinsulatra/jenkins-demo.git', branch:'docker-demo'
      }
    }
    
    stage('Package Helm Chart') {
      steps{
        sh 'helm package .'
      }
    }

    stage('Push to Helm Repo') {
      steps {
        sh 'curl --data-binary "@demo-chart-0.1.0.tgz" https://core.harbor.dev.h.fmlabs.xyz/chartrepo/library'
      }
    }
  }
}
