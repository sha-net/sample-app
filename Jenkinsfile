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
               script {
		  cat <<EOF>> pos-svc.yaml
			{
			    "apiVersion": "v1",
			    "kind": "Pod",
			    "metadata": {
				"name": "sample-app"
			    },
			    "spec": {
				"containers": [
				    {
					"name": "sample-app",
					"image": "${registry}",
					"ports": [
					    {
						"containerPort": 8000
					    }
					]
				    }
				]
			    }
			}
		   EOF
		}
            }
        } //stage('create pod yaml')
        stage('run pod') {
            steps {
               script {
                 TOKEN=`cat /var/run/secrets/kubernetes.io/serviceaccount/token`
                 curl -q -k -X POST https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/shavitns/pods --header "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d@pos-svc.yaml
               }
            }
        }
    }
}
