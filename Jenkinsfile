pipeline {
    agent any

    environment {
      registry = "shavitnetzer/sample-app:${env.BUILD_NUMBER}"
      registryCredential = 'dockerhub'
    }

    stages {
        stage('script') {
            steps {
              sh 'echo ${registryCredential} >> /tmp/test.txt'
              sh 'sleep 90000'
              sh 'ls'
            }
        }
        stage('Build Image') {
            steps {
	       sh 'docker build . -t ${registry}'
            }
        }
        stage('push image') {
            steps {
              script {
                docker.withRegistry( '', registryCredential ) {
                  ${registry}.push()
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
