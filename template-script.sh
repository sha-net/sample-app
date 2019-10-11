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
`export TOKEN=$TOKEN`
NAMESPACE="jenkins"
LB="$TEMPLATE_APP_NAME_lb"
cat <<EOF>> $YAML_FILE
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
    "name": "$TEMPLATE_APP_NAME"
    },
    "spec": {
    "containers": [
        {
        "name": "$TEMPLATE_APP_NAME",
        "image": "$TEMPLATE_IMAGE",
        "ports": [
            {
                "containerPort": $TEMPLATE_APP_PORT
            }
        ]
        }
    ]
    }
}
EOF
fi
#case "$1" in
#        start)
#            echo curl -q -k -X POST https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/$NAMESPACE/pods --header "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d@$YAML_FILE >> log.txt
#            #curl -q -k -X POST https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/$NAMESPACE/pods --header "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d@$YAML_FILE
#            ;;
#         
#        stop)
#            echo curl -q -k -X GET https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/$NAMESPACE/pods/$TEMPLATE_APP_NAME --header "Authorization: Bearer $TOKEN" >> log.txt
#            #curl -q -k -X GET https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/$NAMESPACE/pods/$TEMPLATE_APP_NAME --header "Authorization: Bearer $TOKEN"
##            ;;
#         
#        *)
##            echo $"Usage: $0 {start|stop}"
#            exit 1
# 
#esac
