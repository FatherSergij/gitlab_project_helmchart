#!/bin/bash
#kubectl create ns master
#aws ecr get-login-password --region eu-north-1 | docker login --username AWS \
#      --password-stdin 728490037630.dkr.ecr.eu-north-1.amazonaws.com
#kubectl delete -n master secret regcred --ignore-not-found; \
#kubectl create secret docker-registry regcred \
#      --docker-server=728490037630.dkr.ecr.eu-north-1.amazonaws.com \
#      --docker-username=AWS \
#      --docker-password=$(aws ecr get-login-password --region eu-north-1) \
#      --namespace=master
helm install test .
