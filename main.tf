# main.tf

# Define variables
variable "project_name" {
  description = "Name of the project"
  default     = "robo"
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  default     = "dev"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "database_subnets_cidr_blocks" {
  description = "CIDR blocks for database subnets"
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name        = "${var.project_name}-vpc-${var.environment}"
    Environment = var.environment
  }
}

# Create public subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets_cidr_blocks[count.index]
  availability_zone = "us-east-1a"  # Update with desired AZ
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet-${count.index + 1}-${var.environment}"
    Environment = var.environment
  }
}

# Create private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets_cidr_blocks[count.index]
  availability_zone = "us-east-1a"  # Update with desired AZ

  tags = {
    Name        = "${var.project_name}-private-subnet-${count.index + 1}-${var.environment}"
    Environment = var.environment
  }
}

# Create database subnets
resource "aws_subnet" "database_subnets" {
  count             = length(var.database_subnets_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnets_cidr_blocks[count.index]
  availability_zone = "us-east-1a"  # Update with desired AZ

  tags = {
    Name        = "${var.project_name}-database-subnet-${count.index + 1}-${var.environment}"
    Environment = var.environment
  }
}

# Output VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}
