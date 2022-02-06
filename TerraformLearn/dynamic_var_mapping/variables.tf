variable "users" {
  type = map(any)
  default = {
    UAT = 20
    STAGE = 30
    PROD = 66
  }
}
variable "username" {
  type = string
}
