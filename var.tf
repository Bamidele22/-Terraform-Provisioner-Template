variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "USER" {
  default = "ec2-user"
}

variable "AMIS" {
  
  type = map

  default = {
    us-east-1 = ""
    us-east-2 = ""
  }
}