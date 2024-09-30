variable "project_id" {
  type        = string
  description = "The"
  default = "dev"
}

variable "vpc_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
  
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"

}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "private Subnet CIDR values"

}

variable "us_availability_zone" {
 type        = list(string)
 description = "Availability Zones"
 
}

# variable "aws_public_assoc" {
#   type = list(string)
#   description = "public associate"  
# }

# variable "aws_private_assoc" {
#   type = list(string)
#   description = "Private table associate"
  
# }