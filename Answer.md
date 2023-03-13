# Before to run

I used `terraform/cluster/providers.tf` and `terraform/apps/providers.tf` files to define a GCP backend for tfstate.

Before to run, an apropiate bucket and project id should be defined.

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

Then, tests `apps` tfmodule and create namespaces and helm release

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
