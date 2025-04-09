terraform {
  cloud {
    organization = "Techitblog"
    workspaces {
      name = "network"
    }
  }
}