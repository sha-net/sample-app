#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, usage ./$0 APP-NAME APP-PORT IMAGE"
    exit 0
else
TEMPLATE_APP_NAME="$2"
TEMPLATE_APP_PORT="$3"
TEMPLATE_IMAGE="$4"
YAML_FILE="pod-svc.yaml"
TOKEN=`cat /var/run/secrets/kubernetes.io/serviceaccount/token`
case "$1" in
        start)
            sed -i "s/TEMPLATE-APP-NAME/$TEMPLATE_APP_NAME/g" $YAML_FILE
            sed -i "s/TEMPLATE-APP-PORT/$TEMPLATE_APP_PORT/g" $YAML_FILE
            sed -i "s/TEMPLATE-IMAGE/shavitnetzer\/sample-app:78/g" $YAML_FILE
            #sed -i "s/TEMPLATE-IMAGE/$TEMPLATE_IMAGE/g" $YAML_FILE
            curl -q -k -X POST https:///$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/jenkins/pods --header \"Authorization: Bearer $TOKEN\" -H \"Content-Type: application/json\" -d@$YAML_FILE
            ;;
         
        stop)
            curl -q -k -X GET https:///$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/jenkins/pods/$TEMPLATE_APP_NAME --header \"Authorization: Bearer $TOKEN\"
            ;;
         
        *)
            echo $"Usage: $0 {start|stop}"
            exit 1
 
esac
fi
