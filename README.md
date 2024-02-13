# Udacity Project - Operationalizing a Coworking Space Microservice

## Initial Set Up

### 1. Setting up Elastic Container Repositories (ECRs)

1. Create `coworking` private repository in the ECR console.
2. Create `coworking-db` private repository in the ECR console.

### 2. Setting up CodeBuild

1. Create a CodeBuild project in AWS
2. Use Amazon Linux with the latest image version
3. Create an appropriate service role for it
4. Set the following environment variables:
   - AWS_DEFAULT_REGION: Your profile's default region (e.g. "us-east-1")
   - AWS_ACCOUNT_ID: Your profile's account ID
   - APP_IMAGE_REPO_NAME: AWS ECR repo name for the app (e.g. "coworking")
   - DB_IMAGE_REPO_NAME: AWS ECR repo name for the db (e.g. "coworking-db")
   - IMAGE_TAG: "latest" (this will get changed automatically when deployments are done via Kubernetes)

### 3. Setting up Elastic Kubernetes Service (EKS)

1. Create EKS called `coworking` with a NodeGroup (any name for the NodeGroup would do).

## Daily Set Up

Set up needed to be done after the initial setup completed.

1. Click on **Launch AWS Gateway**, take note of all three credentials.
2. Run `aws configure --profile udacityfed` and `aws configure set aws_session_token [SESSION TOKEN] --profile udacityfed`. Enter credentials from #1.
3. Run this command to configure local `kubectl` to connect to AWS EKS:
   ```bash
   aws eks --region us-east-1 update-kubeconfig --name coworking --profile udacityfed
   ```
4. Run thi