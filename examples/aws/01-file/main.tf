terraform {
  required_version = ">= 0.12.1"
  backend "local" {}
}

resource "template_file" "file" {
  template = "${path.module}/template.txt"
  vars     = {
    company = "goci"
  }
}

resource "local_file" "file" {
  filename = "${path.module}/dist/out.txt"
  content  = template_file.file.rendered
}
