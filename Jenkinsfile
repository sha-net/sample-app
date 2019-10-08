pipeline {
    agent any

    environment {
      registry = "shavitnetzer/sample-app"
      registryCredential = 'dockerhub'
    }

    stages {
        stage('script') {
            steps {
              sh 'ls && sudo service docker start'
            }
        }
        stage('Build Image') {
            steps {
		script {
		   docker.build registry + ":$BUILD_NUMBER"
		}
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
