# Enable RAM sharing with AWS Organizations (Management Account only)
resource "aws_ram_organization_settings" "enable_sharing" {
  enable_sharing_with_aws_organization = true
}

# Look up VPC by name tag "my-vpc" (avoids hardcoding VPC ID)
data "aws_vpc" "target_vpc" {
  filter {
    name   = "tag:Name"
    values = ["my-vpc"]  # Your VPC's name tag
  }
}

# Share ALL subnets in the VPC with Sandbox OU
resource "aws_ram_resource_share" "sandbox_subnet_share" {
  name                      = "sandbox-subnet-share"
  allow_external_principals = false  # Restrict to AWS Org
  principals                = [var.sandbox_ou_arn]  # Sandbox OU ARN
}

# Fetch all subnets in the VPC (dynamically using the VPC name)
data "aws_subnets" "shared_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.target_vpc.id]  # Uses VPC ID fetched by name
  }
}

# Attach each subnet to the RAM share
resource "aws_ram_resource_association" "subnet_share" {
  for_each           = toset(data.aws_subnets.shared_subnets.ids)
  resource_arn       = "arn:aws:ec2:${var.region}:${var.management_account_id}:subnet/${each.value}"
  resource_share_arn = aws_ram_resource_share.sandbox_subnet_share.arn
}