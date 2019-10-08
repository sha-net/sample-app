pipeline {
    agent any

    environment {
      registry = "shavitnetzer/sample-app"
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
	       sh 'docker build -t ${registry}":"${env.BUILD_NUMBER} .'
               sh 'docker push ${registry}":"${env.BUILD_NUMBER}'
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
