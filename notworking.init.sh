#!/bin/sh
# $1: EKS cluster name e.g. coworking
# $2: AWS Profile e.g. udacityfed
# Sample command to run:
# init.sh coworking udacityfed


aws eks --region us-east-1 update-kubeconfig --name $1 --profile $2

ClusterName=$1
RegionName=us-east-1
FluentBitHttpPort='2020'
FluentBitReadFromHead='Off'
[[ ${FluentBitReadFromHead} = 'On' ]] && FluentBitReadFromTail='Off'|| FluentBitReadFromTail='On'
[[ -z ${FluentBitHttpPort} ]] && FluentBitHttpServer='Off' || FluentBitHttpServer='On'
curl https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluent-bit-quickstart.yaml | sed 's/{{cluster_name}}/'${ClusterName}'/;s/{{region_name}}/'${RegionName}'/;s/{{http_server_toggle}}/"'${FluentBitHttpServer}'"/;s/{{http_server_port}}/"'${FluentBitHttpPort}'"/;s/{{read_from_head}}/"'${FluentBitReadFromHead}'"/;s/{{read_from_tail}}/"'${FluentBitReadFromTail}'"/' | kubectl apply -f -

helm repo add $1 https://charts.bitnami.com/bitnami

# helm install db $1/postgresql
helm install db oci://registry-1.docker.io/bitnamicharts/postgresql

export POSTGRES_PASSWORD=$(kubectl get secret --namespace default db-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
echo "PostgreSQL Password: $POSTGRES_PASSWORD"

kubectl autoscale deployment db-postgresql-0 --cpu-percent=50 --min=1 --max=10

kubectl port-forward --namespace default svc/db-postgresql 5432:5432 & PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432 < ./db/1_create_tables.sql

kubectl port-forward --namespace default svc/db-postgresql 5432:5432 & PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432 < ./db/2_seed_users.sql

kubectl port-forward --namespace default svc/db-postgresql 5432:5432 & PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432 < ./db/3_seed_tokens.sql