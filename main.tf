terraform {
  backend "remote" {
    organization = "footprintmedia"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

# An example resource that does nothing.
resource "null_resource" "example1" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}

resource "null_resource" "example2" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}

resource "null_resource" "example3" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}
