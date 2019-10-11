pipeline {
    agent any

    environment {
      registry = "shavitnetzer/sample-app:${env.BUILD_NUMBER}"
      registryCredential = 'dockerhub'
      timeout = 240
      app_name = "sample-app"
    }

    stages {

        stage('Build Image') {
            steps {
	            script {
                    dockerImage = docker.build registry
                }
            }
        } //stage('Build Image')

        stage('push image') {
            steps {
              script {
                docker.withRegistry( '', registryCredential ) {
                  dockerImage.push()
                }
              }
            }
        } //stage('push image')

        stage('create pod') {
            steps {
                  sh 'chmod +x template-script.sh'
		  sh './template-script.sh ${app_name} 8000 ${registry}'
            }
        } //stage('create pod yaml')

        stage('run pod') {
            steps {
                 sh 'curl -q -k -X POST https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/jenkins/pods --header "Authorization: Bearer `cat /var/run/secrets/kubernetes.io/serviceaccount/token`" -H "Content-Type: application/json" -d@pod-svc.yaml'
                 sh 'sleep ${timeout}'
            }
        }

        stage('stop pod') {
            steps {
                 sh 'curl -q -k -X DELETE https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/jenkins/pods/${app_name} --header "Authorization: Bearer `cat /var/run/secrets/kubernetes.io/serviceaccount/token`"'
            }
        }

    }
}
