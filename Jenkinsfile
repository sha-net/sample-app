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
        stage('create and run pod') {
            steps {
                  sh 'chmod +x template-script.sh'
		  sh './template-script.sh start sample-app 8000 ${registry}'
            }
        } //stage('create pod yaml')
        stage('run pod') {
            steps {
                 sh 'TOKEN=`cat /var/run/secrets/kubernetes.io/serviceaccount/token`'
                 sh 'curl -q -k -X POST https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/jenkins/pods --header "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d@pod-svc.yaml'
                 sh 'sleep 360'
		 sh './template-script.sh stop'
                 //sh 'PODIP=`curl -q -k -X GET https://10.22.0.1:443/api/v1/namespaces/jenkins/pods/sample-app --header "Authorization: Bearer $TOKEN"  | grep podIP |cut -d'"' -f4`'
                 //sh 'curl $PODIP:8000'
                 //sh 'curl Delete the pod'
            }
        }
    }
}
