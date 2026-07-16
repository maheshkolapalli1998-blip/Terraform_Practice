variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {
    Name = ""
  }
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = ""
}

variable "subnet_tags" {
  description = "A map of tags to assign to the subnet"
  type        = map(string)
  default     = {
    Name = ""
  }
}