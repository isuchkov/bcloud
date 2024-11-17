variable "hpa_name" {
  default = "hpa"
}

variable "namespace" {
  default = "default"
}
variable "deployment_name" {}
variable "min_replicas" {
  default = 1
}
variable "max_replicas" {
  default = 10
}
variable "cpu_threshold" {
  default = 80
}
variable "memory_threshold" {
  default = 80
}
