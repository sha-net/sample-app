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
               sh 'echo docker build -t ${registry} .'
	       sh 'docker build -t ${registry} .'
               sh 'echo docker push ${registry}'
               sh 'docker push ${registry}'
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
