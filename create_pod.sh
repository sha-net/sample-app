#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 0
else
registry=$1
cat <<EOF>> pod-svc.yaml
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
fi
