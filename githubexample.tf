terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.3.2"
    }
  }
}

provider "github" {
  token = "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"
}

resource "github_repository" "example" {
  name        = "simplilearn-repo"
  visibility  = "private"
}
