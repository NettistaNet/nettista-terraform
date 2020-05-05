# Create virtual servers for a Kubernetes-Cluster

## Prerequisties

You need:
* the terraform cli (https://www.terraform.io/)
* the hcloud teraform provider (https://github.com/hetznercloud/terraform-provider-hcloud)

## Create API-Token
Create API-Token. 
1. Open https://console.hetzner.cloud
2. Choose your project, go to Access → Tokens and create a new token

## Execute
Create servers.
```
export HCLOUD_TOKEN=<generated token>
terraform init
terraform plan
terraform apply
```

### Destroy
Remove all servers.
```
terraform destroy
```