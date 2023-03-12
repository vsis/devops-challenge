terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
  }
}

module main {
  source = "../.."
}

resource "test_assertions" "name_is_app1" {
  component = "name_is_app1"

  equal "release_name" {
     description = "Release name is app1"
     got = module.main.release_name
     want = "app1"
  }
}

