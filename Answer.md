# How to run

First, create the cluster
```
cd terraform/cluster
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

Then, get cluster credentials
```
gcloud container clusters get-credentials production --zone=europe-southwest
```

Then, tests app tfmodule and create namespace and helm release

```
cd ../apps
terraform init
terraform test
terraform plan -out tfplan
terraform apply tfplan
```

Finally, test released app


```
helm test app1
```
