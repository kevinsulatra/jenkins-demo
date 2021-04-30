pipeline {
  environment {
    registry = "kevinsulatra/pipeline-demo"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent {
    kubernetes {
    defaultContainer 'jnlp'
    yaml """
    apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
serviceAccountName: jenkins
containers:
- name: jnlp
  image: jenkins/inbound-agent:4.6-1
  command:
  - cat
  tty: true
  volumeMounts:
    - mountPath: "/var/run/docker.sock"
      name: workspace-volume
- name: docker
  image: docker:latest
  command:
  - cat
  tty: true
  volumeMounts:
  - mountPath: /var/run/docker.sock
    name: docker-sock
volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock
  - name: jenkins
    persistentVolumeClaim:
      claimName: jenkins
    """
    }
  }
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
