variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}
