# Deploying n2n2-tribes
Currently, the deployment is partially manual.
The reason is mqtt port 1883, 8883 and loadbalancer issues.

DNS
Current 
tribes.n2n2.chat	A	Simple	-	3.82.104.221

Ideal Router
tribes.n2n2.chat	A	Simple	-	ELB

# Stack DevOps/CI
Stack is currently deployed via terraform.

```
terraform apply
terraform show
terraform destruct
```

Elastic Beanstalk Docker Image
Code Pipeline

To start see [Docker](basic_docker.md)

## AWS S3
```
aws s3 sync ~/Desktop/N2N2/n2n2-tribes/ s3://n2n2-keys/n2n2-tribes --exclude "*" --include ".env"
```

To start see [letsencrypt](letsencrypt.md)