# Udacity Project - Operationalizing a Coworking Space Microservice

## Initial Set Up

1. Create EKS called `coworking` and a NodeGroup also called `coworking`.

## Daily Set Up

Set up needed to be done after the initial setup completed.

1. Click on **Launch AWS Gateway**, take note of all three credentials.
2. Run `aws configure --profile udacityfed` and `aws configure set aws_session_token [SESSION TOKEN] --profile udacityfed`. Enter credentials from #1.
3. Run this command to configure local `kubectl` to connect to AWS EKS:
   ```bash
   aws eks --region us-east-1 update-kubeconfig --name coworking --profile udacityfed
   ```
4. Run thi