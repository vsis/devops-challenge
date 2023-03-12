# Split cluster and apps

I separated cluster creation and apps deployment, in order to avoid use gcloud module output to helm and kubernetes provider config. See: https://itnext.io/terraform-dont-use-kubernetes-provider-with-your-cluster-resource-d8ec5319d14a

So, to deploy everything, first one must apply `cluster` directory. Then, get cluster credentials, and last, apply `apps` directory.

In order to get cluster credentials I run `gcloud container clusters get-credentials production --zone=europe-southwest`.

So, the execution is something like this:

```
# Apply cluster
cd cluster
terraform init
terraform plan -out tfplan
terraform apply tfplan

# Get cluster credentials
gcloud container clusters get-credentials production --zone=europe-southwest

# Apply apps
cd ../apps
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

# Testing

I only wrote tests for apps tf module. It needs an already created cluster. Otherwise, one of the tests will be skipped.

They run with `terraform test` command.
