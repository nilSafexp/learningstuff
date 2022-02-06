resource "github_repository" "tf-git" {
  name        = "tera-git"
  description = "My first practical git repo creation"
  visibility  = "public"
  auto_init   = true

}

resource "github_repository" "tf-git2" {
  name        = "tera-git2"
  description = "My 2nd practical git repo creation"
  visibility  = "public"
  auto_init   = true

}