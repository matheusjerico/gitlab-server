variable "instance_type" {
  type        = string
  description = "The instance type."
}

variable "instance_count" {
  type        = number
  description = "The number of machines."
}

variable "key_path" {
  type        = string
  description = "The complete path that contain ssh private key."
}
variable "user_ec2" {
  type        = string
  description = "The user to connect on EC2 instance."
  default     = "ubuntu"
}

variable "my_ipv4_address" {
  type        = list(string)
  description = "My IPV4 address."
}