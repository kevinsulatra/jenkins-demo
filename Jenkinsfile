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
spec:
  volumes:
  - name: docker-socket
    emptyDir: {}
  containers:
  - name: docker
    image: docker:19.03.1
    command:
    - sleep
    args:
    - 99d
    volumeMounts:
    - name: docker-socket
      mountPath: /var/run
  - name: docker-daemon
    image: docker:19.03.1-dind
    securityContext:
      privileged: true
    volumeMounts:
    - name: docker-socket
      mountPath: /var/run
    """
    }
  }
  stages {
    stage('Cloning Git') {
      steps {
        git url:'https://github.com/kevinsulatra/jenkins-demo.git', branch:'docker-demo'
      }
    }
    stage('Building Image') {
      steps{
        container('docker'){
          script {
            dockerImage = docker.build "$registry:latest"
          }
        }
      }
    }
    stage('Checking Image'){
      steps {
        writeFile file: 'anchore_images', text: 'docker.io/kevinsulatra/pipeline-demo:latest'
        anchore name: 'anchore_images'
      }
    }
    stage('Deploying Image') {
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
//     stage('Remove Unused docker image') {
//       steps{
//         container('docker'){
//           sh "docker rmi $registry:$BUILD_NUMBER"
//         }
//       }
//     }
//   }
// }
