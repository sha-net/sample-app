#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, usage ./$0 APP-NAME APP-PORT IMAGE"
    exit 0
else
TEMPLATE-APP-NAME=$2
TEMPLATE-APP-PORT=$3
TEMPLATE-IMAGE=$4
YAML-FILE="pod-svc.yaml"
TOKEN=`cat /var/run/secrets/kubernetes.io/serviceaccount/token`
case "$1" in
        start)
            sed -i "s/TEMPLATE-APP-NAME/$TEMPLATE-APP-NAME/g" $YAML-FILE
            sed -i "s/TEMPLATE-APP-PORT/$TEMPLATE-APP-PORT/g" $YAML-FILE
            sed -i "s/TEMPLATE-IMAGE/$TEMPLATE-IMAGE/g" $YAML-FILE
            curl -q -k -X POST https:///$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/jenkins/pods --header "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d@$YAML-FILE
            ;;
         
        stop)
            curl -q -k -X GET https:///$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/jenkins/pods/$TEMPLATE-APP-NAME --header "Authorization: Bearer $TOKEN"
            ;;
         
        *)
            echo $"Usage: $0 {start|stop}"
            exit 1
 
esac
