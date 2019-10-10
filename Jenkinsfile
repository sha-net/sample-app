pipeline {
    agent any

    environment {
      registry = "shavitnetzer/sample-app:${env.BUILD_NUMBER}"
      registryCredential = 'dockerhub'
    }

    stages {
        stage('script') {
            steps {
              //sh 'echo ${registryCredential} >> /tmp/test.txt'
              //sh 'sleep 90000'
              sh 'ls'
            }
        }
        stage('Build Image') {
            steps {
	       script {
                 dockerImage = docker.build registry + ":$BUILD_NUMBER"
               }
            }
        }
        stage('push image') {
            steps {
              script {
                docker.withRegistry( '', registryCredential ) {
                  dockerImage.push()
                }
              }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
