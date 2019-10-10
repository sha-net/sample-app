pipeline {
    agent any

    environment {
      registry = "shavitnetzer/sample-app:${env.BUILD_NUMBER}"
      registryCredential = 'dockerhub'
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
        stage('create pod yaml') {
            steps {
                  sh 'chmod +x create_pod.sh'
		  sh './create_pod.sh ${registry}'
            }
        } //stage('create pod yaml')
        stage('run pod') {
            steps {
                 sh 'TOKEN=`cat /var/run/secrets/kubernetes.io/serviceaccount/token`'
                 sh 'curl -q -k -X POST https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/shavitns/pods --header "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d@pod-svc.yaml'
            }
        }
    }
}
