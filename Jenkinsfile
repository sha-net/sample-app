pipeline {
    agent any

    environment {
      registry = "shavitnetzer/sample-app:${env.BUILD_NUMBER}"
      registryCredential = 'dockerhub'
    }

    stages {
        stage('script') {
            steps {
              sh 'ls'
            }
        }
        stage('Build Image') {
            steps {
	       sh 'sudo docker build . -t ${registry}'
               sh 'sudo docker push ${registry}'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
		sh 'docker'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
