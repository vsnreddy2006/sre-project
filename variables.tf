variable "key" {
  description = "Name of the AWS Key Pair to associate with the ELK instance."
  default = "my-ssh-key"
}
variable "private_key" {
  description = "Path to the local SSH private key file associated with the AWS Key Pair."
  default = "~/.ssh/id_rsa.pub"
}
variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-west-2"
}
variable "aws_vpc" {
  description = "AWS region to launch servers."
  default     = "vpc-a03059d9"
}
variable "aws_subnet_id" {
  description = "AWS region to launch servers."
  default     = "subnet-3728f44e"
}