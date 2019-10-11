#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, usage ./$0 APP-NAME APP-PORT IMAGE"
    exit 0
else
TEMPLATE_APP_NAME="$1"
TEMPLATE_APP_PORT="$2"
TEMPLATE_IMAGE="$3"
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
