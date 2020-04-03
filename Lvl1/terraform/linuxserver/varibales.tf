variable "prefix" {
    type        = string
    description = "Prefix to be used for the resources"
    default     = "ProjectDemo"
}

variable "vpc_cidr" {
    type        = string
    description = "VPC CIDR to be used for NRL"
    default     = "10.238.0.0/16"
}

variable "PublicSubnetCidrs" {
    type        = string
    description = "Public Subnet CIDRs"
    default     = "10.238.0.0/24"
}

variable "Ami_Id" {
    type        = string
    description = "Image to be used for the servers"
    default     = "ami-08bc77a2c7eb2b1da"
}

variable "InstanceType" {
    type        = string
    description = "Instance type to be used for AD Server"
    default     = "t2.micro"
  
}

variable "key_name" {
    type        = string
    description = "Key pair name to used for the instances"
    default     = "demo"
}
