terraform {
  required_version = ">= 0.12.1"
  backend "local" {}
}

resource "null_resource" "example" {
  triggers = {
    uuid = uuid()
  }
}
