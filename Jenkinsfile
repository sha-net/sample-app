pipeline {
    agent any

    environment {
      registry = "shavitnetzer/sample-app"
      registryCredential = 'dockerhub'
    }

    stages {
        stage('script') {
            steps {
              sh 'ls && docker'
            }
        }
        stage('Build Image') {
            steps {
		script {
		   docker build -t registry + ":$BUILD_NUMBER" .
                   docker push registry + ":$BUILD_NUMBER"
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
