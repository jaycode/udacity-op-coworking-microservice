# Udacity Project - Operationalizing a Coworking Space Microservice

## Initial Set Up

### 1. Setting up Elastic Container Repositories (ECRs)

1. Create `coworking` private repository in the ECR console. Enable tag immutability.
2. Create `coworking-db` private repository in the ECR console. Enable tag immutability.

### 2. Setting up CodeBuild

1. Create a CodeBuild project in AWS
2. Source: GitHub https://github.com/jaycode/udacity-op-coworking-microservice.git
3. Webhook: Rebuild every time a code change is pushed to this repository
4. Webhook Event filter groups: PUSH and PULL_REQUEST_MERGED
5. Build specifications: Use buildspec file (buildspec.yml)
6. Use Amazon Linux with the latest image version
7. Create an appropriate service role for it
8. Add the following environment variables from **Additional Configuration**:
   - AWS_DEFAULT_REGION: Your profile's default region (e.g. "us-east-1")
   - AWS_ACCOUNT_ID: Your profile's account ID
   - APP_IMAGE_REPO_NAME: AWS ECR repo name for the app (e.g. "coworking")
   - DB_IMAGE_REPO_NAME: AWS ECR repo name for the db (e.g. "coworking-db")
   - IMAGE_TAG: "latest" (this will get changed automatically when deployments are done via Kubernetes)

### 3. Setting up Elastic Kubernetes Service (EKS)

1. Create an IAM role:
   - Trusted Entity Type: AWS service > EKS - Cluster
   - Name: eksServiceRole
2. Create EKS called `coworking` with a NodeGroup (any name for the NodeGroup would do).
   - Use the IAM role created above.
   - Cluster endpoint access: Public
   - Configure observability > Control plane logging: Enable all logs.

### 4. Run the init script

```
./init.sh [CLUSTER NAME] [PROFILE NAME]
```

For example:

```
./init.sh coworking udacityfed
```

## Daily Set Up

Set up needed to be done after the initial setup completed.

1. Click on **Launch AWS Gateway**, take note of all three credentials.
2. Run `aws configure --profile udacityfed` and `aws configure set aws_session_token [SESSION TOKEN] --profile udacityfed`. Enter credentials from #1.
3. Run this command to configure local `kubectl` to connect to AWS EKS:
   ```bash
   aws eks --region us-east-1 update-kubeconfig --name coworking --profile udacityfed
   ```
4. Run thi

## How to delete a deployment (or in other words, remove pods and never see them created again)

If the pod name is `app-db-6854d755c6-2xcf8`, for example, then the deployment name is `app-db`. Run this command to delete it:

```
kubectl delete deployment app-db
```