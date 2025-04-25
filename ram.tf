# Creation
resource "aws_ram_resource_share" "subnet_share" {
  name                      = var.ram_name
  allow_external_principals = false # Restrict sharing to AWS Organization only
  tags                      = local.tags
}

# Associatin
resource "aws_ram_resource_association" "private_subnets" {
  for_each           = { for idx, subnet in aws_subnet.private : idx => subnet }
  resource_arn       = each.value.arn
  resource_share_arn = aws_ram_resource_share.subnet_share.arn
}

# Association
resource "aws_ram_resource_association" "public_subnets" {
  for_each           = { for idx, subnet in aws_subnet.public : idx => subnet }
  resource_arn       = each.value.arn
  resource_share_arn = aws_ram_resource_share.subnet_share.arn
}

# Shares resources with the Sandbox OU
resource "aws_ram_principal_association" "sandbox_ou" {
  principal          = var.ou_arn # e.g., "arn:aws:organizations::123456789012:ou/o-abc123/ou-def456"
  resource_share_arn = aws_ram_resource_share.subnet_share.arn
}