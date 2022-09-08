terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.3.2"
    }
  }
}

provider "github" {
  tgtoken = "ghp_7r1eridOgquI75jW3t3456qO7xzQyuhhSvpvOg3KiLcU"
}

resource "github_repository" "example" {
  name        = "simplilearn-repo"
  visibility  = "private"
}
