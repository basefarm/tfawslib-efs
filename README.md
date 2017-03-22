# tfawslib-efs
Terraform module implementing an Elastic File-System on AWS

## Required Inputs:  
+ variable "costcenter" { type="string" }  
+ variable "nameprefix" { type="string" }  
+ variable "vpc" { type = "string" }  
+ variable "subnets" { type = "list" } - List of subnets where the file-system should be available  
  
## Optional Inputs:  
+ variable "security_groups" { default = "" type = "list" } - List of security groups to be given access to the file-system in addition to the SG created
+ variable "performance_mode" { default = "generalPurpose" type = "string" } - "generalPurpose" or "maxIO"
  
## Outputs:  
+ "sg" - Security group that can be used for accessing the mount targets
+ "id" - ID of EFS, used to construct mountpoint as id.efs.aws-region.amazonaws.com

## Example:  
(Assumes the usage of the VPC example or similar)  
```hcl
module "efs" {
    source = "git@github.com:basefarm/tfawslib-efs"
    costcenter = "${var.costcenter}"
    nameprefix = "${var.nameprefix}"
    vpc = "${module.vpc.vpcid}"
    subnets = "${module.vpc.appnets}"
}
output "nfsmount" { value = "${module.efs.id}.efs.${module.vpc.region}.amazonaws.com" }
output "access_sg" { value = "${module.efs.access_sg}" }
```
