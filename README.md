### Set ENV Variable

```bash
export ECR_REPO=""
```

### Build Docker Image

```bash
docker build -t pvs_demo .
```

### Run Docker Image

```bash
docker run --name pvs_demo -d -p 8040:8040  <image_name>
```

### Authenticate with ECR

```bash
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin $ECR_REPO
```

### Tag Image with ECR repo

```bash
docker tag pvs_demo:latest $ECR_REPO
```

### Push Image to ECR

```bash
docker push $ECR_REPO
```

### Pull Image from ECR

```bash
docker pull $ECR_REPO
```
