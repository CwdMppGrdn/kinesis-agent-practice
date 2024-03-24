variable "az_a" {
  type    = string
  default = "ap-northeast-1a"
}

variable "ssm_parameter_name" {
  type    = string
  default = "/kinesis-agent/config"
}
