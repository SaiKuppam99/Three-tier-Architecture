#!/bin/bash

terraform destroy -var-file=environments/dev/variables.tfvars  --auto-approve=true