output "printfirst" {
    value = "first users is ${join("--<",var.users)}"
}
output "hellowoldupper" {
    value = "first users is ${upper(var.users[0])}"
}
output "hellowoldlower" {
    value = "first users is ${lower(var.users[2])}"
}
output "hellowoldtitle" {
    value = "first users is ${title(var.users[1])}"
}
