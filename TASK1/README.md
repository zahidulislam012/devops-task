# Company Github repo

```bash
https://github.com/zahidulislam012/company-repo
```
## Pre Requisites
1. Add a label to a node
```bash 
kubectl label nodes <your-node-name> sample=true
```
2. Create Persistance volume
3. Create a volume claimer
4. Create a Jenkins deployment manifest for auto-deployment
5. create a Service for Jenkins Deployment file
6. create a webhook on GitHub to Jenkins for auto-deployment on a specific workspace which is written on the deployment file

## Installation

```bash 
kubectl create -f pv.yaml
kubectl create -f pvc.yaml
kubectl create -f jenkins-deployment.yaml
kubectl create -f jenkins-service.yaml
kubectl create -f deployment.yaml
kubectl create -f service.yaml
```