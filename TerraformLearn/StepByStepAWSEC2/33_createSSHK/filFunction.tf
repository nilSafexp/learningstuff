output "printfile" {
  //path.module --> print only current directory path
  // Below line will print content also using ()
  value = file("${path.module}/file.txt")
}
