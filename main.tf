#EFS
#variable "" { default="" type = "string" }
variable "costcenter" { type="string" }
variable "nameprefix" { type="string" }
variable "vpc" { type = "string" }
variable "subnets" { type = "list" }
#variable "security_groups" { default = ""] type = "list" }
variable "performance_mode" { default = "generalPurpose" type = "string" }