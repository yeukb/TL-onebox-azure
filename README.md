# Prisma Cloud Compute OneBox

This is to create a Prisma Cloud Compute OneBox installation on Azure.

## Prequisites:
1. Terraform v1.0 and above

2. Prisma Cloud Compute license key

3. URL to download Prisma Cloud Compute Edition installation tarball



## Deployment
1. Update the "terraform.tfvars" file with the necessary information.

2. Run "terraform init"

3. Run "terraform apply"

4. VM will be deployed. It takes about 10-15 minutes for it to be fully ready.

5. The URL to the Conosole will be shown in the terraform outputs.



## Removing The VM

1. Run "terraform destroy"