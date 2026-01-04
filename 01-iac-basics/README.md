# 01 - IaC Basics & Terraform Introduction

## What is Infrastructure as Code (IaC)?

**Infrastructure as Code (IaC)** is the practice of managing and provisioning computing infrastructure through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools.

### Key Benefits of IaC:
- **Version Control**: Track infrastructure changes like code
- **Repeatability**: Recreate identical environments consistently
- **Automation**: Reduce manual errors and deployment time
- **Documentation**: Infrastructure is self-documented
- **Scalability**: Easy to scale resources up or down
- **Cost Efficiency**: Pay only for what you use
- **Disaster Recovery**: Quickly rebuild infrastructure

---

## What is Terraform?

**Terraform** is an open-source Infrastructure as Code tool developed by HashiCorp. It allows you to define, preview, and deploy cloud infrastructure using a declarative configuration language (HCL - HashiCorp Configuration Language).

### Key Features:
- **Multi-Cloud Support**: Works with AWS, Azure, GCP, and 100+ providers
- **Declarative Language**: You describe the desired state, not the steps
- **State Management**: Tracks infrastructure state in a state file
- **Planning**: Preview changes before applying them
- **Modularity**: Reuse configurations through modules
- **Community-Driven**: Large ecosystem of pre-built modules

### Terraform Workflow:
1. **Write** - Define infrastructure in `.tf` files
2. **Plan** - Preview changes with `terraform plan`
3. **Apply** - Deploy infrastructure with `terraform apply`
4. **Destroy** - Remove infrastructure with `terraform destroy`

---

## Exercise Overview

This folder contains basic Terraform configurations to demonstrate core concepts:
- Creating your first Terraform files
- Understanding resource definitions
- Managing outputs
- Basic Terraform commands

---

## Files in This Directory

### 1. `first-ec2.tf`
The primary configuration file where infrastructure resources are defined.

**Sections Explained:**

#### **Terraform Block**
```hcl
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```
- Specifies Terraform version requirements
- Declares required providers (AWS in this case)
- Ensures compatibility and consistent behavior

#### **Provider Block**
```hcl
provider "aws" {
  region = "us-east-1"
}
```
- Configures the AWS provider
- Sets the default region for all resources
- Authentication happens through AWS credentials

#### **Resource Blocks**
```hcl
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  tags = {
    Name = "terraform-basics"
  }
}
```
- Defines cloud infrastructure resources
- `aws_instance` is the resource type
- `example` is the local identifier
- Properties define the resource configuration
- Tags help organize and identify resources

---

### 2. `vpc.tf`
Defines input variables that make configurations reusable and flexible.

**Sections Explained:**

#### **Variable Block**
```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
```
- `description`: Documents the variable's purpose
- `type`: Specifies the data type (string, number, bool, list, map, etc.)
- `default`: Optional default value if not provided
- Can be overridden via CLI, environment variables, or `.tfvars` files

#### **Benefits:**
- Makes configurations reusable across environments
- Separates variable values from configuration logic
- Enables parameterization for different use cases

---

## Commands Executed

### Initial Setup
```bash
# Initialize Terraform in the directory
terraform init
```
Downloads provider plugins and sets up the working directory.

### Validation
```bash
# Validate the configuration syntax
terraform validate
```
Checks if the HCL syntax is correct.

### Planning
```bash
# Preview changes without applying them
terraform plan
```
Shows what resources will be created, modified, or destroyed.

### Applying
```bash
# Deploy infrastructure
terraform apply
```
Creates resources defined in your configuration files.

### Destroying
```bash
# Remove all infrastructure
terraform destroy
```
Tears down resources managed by this Terraform configuration.

### Additional Useful Commands
```bash
# View the current state
terraform show

# Format code according to Terraform standards
terraform fmt

# List all outputs
terraform output
```

---

## What I Learned

✓ Infrastructure as Code enables reproducible, version-controlled infrastructure  
✓ Terraform uses a declarative approach - describe desired state, not steps  
✓ The workflow is: Write → Plan → Apply  
✓ State files track current infrastructure state  
✓ Providers connect Terraform to cloud platforms  
✓ Resources are the building blocks of infrastructure  

---

