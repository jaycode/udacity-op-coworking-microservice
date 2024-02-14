#!/bin/sh
# $1: EKS cluster name e.g. coworking
# $2: AWS Profile e.g. udacityfed
# Sample command to run:
# init.sh coworking udacityfed

aws eks --region us-east-1 update-kubeconfig --name $1 --profile $2

# Run deployment yamls
kubectl apply -f deployment/

# Install app

# ClusterName=$1
# RegionName=us-east-1
# FluentBitHttpPort='2020'
# FluentBitReadFromHead='Off'
# [[ ${FluentBitReadFromHead} = 'On' ]] && FluentBitReadFromTail='Off'|| FluentBitReadFromTail='On'
# [[ -z ${FluentBitHttpPort} ]] && FluentBitHttpServer='Off' || FluentBitHttpServer='On'
# curl https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluent-bit-quickstart.yaml | sed 's/{{cluster_name}}/'${ClusterName}'/;s/{{region_name}}/'${RegionName}'/;s/{{http_server_toggle}}/"'${FluentBitHttpServer}'"/;s/{{http_server_port}}/"'${FluentBitHttpPort}'"/;s/{{read_from_head}}/"'${FluentBitReadFromHead}'"/;s/{{read_from_tail}}/"'${FluentBitReadFromTail}'"/' | kubectl apply -f -
