variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

# New variables for RAM sharing
variable "management_account_id" {
  description = "AWS Account ID of the management account"
  type        = string
}

variable "sandbox_ou_arn" {
  description = "arn:aws:organizations::640168434456:ou/o-eggplpncq5/ou-ocmf-90vn9dk3"
  type        = string
}

variable "enable_ram_sharing" {
  description = "Whether to enable RAM sharing with AWS Organizations"
  type        = bool
  default     = true
}