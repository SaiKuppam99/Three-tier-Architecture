#!/bin/bash

terraform init -backend-config=environments/dev/backend.config
terraform plan -var-file=environments/dev/variables.tfvars  
terraform apply -var-file=environments/dev/variables.tfvars  --auto-approve=true
# terraform destroy -var-file=environments/dev/variables.tfvars  --auto-approve=true