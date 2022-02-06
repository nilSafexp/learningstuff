output "printfirst" {
  value = "This is list example ${lookup(var.users, "${var.username}")}"
}
