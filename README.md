# Terraform Modules Test Repository

This repository contains a modular Terraform configuration for deploying AWS infrastructure including VPC, Subnet, EC2 instances, and S3 buckets. The configuration supports multiple environments through Terraform workspaces.

## 🏗️ Architecture Overview

This Terraform configuration deploys the following AWS resources:

- **VPC** - Virtual Private Cloud with custom CIDR block
- **Subnet** - Public/Private subnet within the VPC
- **EC2 Instance** - Virtual machine with configurable AMI and instance type
- **S3 Bucket** - Object storage with unique naming and configurable ACL

## 📁 Project Structure

```
terraform-modules-test/
├── main.tf                 # Main configuration file
├── variables.tf            # Variable definitions
├── outputs.tf              # Output values
├── README.md               # This file
└── modules/
    ├── vpc/
    │   ├── main.tf         # VPC resource configuration
    │   ├── variables.tf    # VPC module variables
    │   └── outputs.tf      # VPC module outputs
    ├── subnet/
    │   ├── main.tf         # Subnet resource configuration
    │   ├── variables.tf    # Subnet module variables
    │   └── outputs.tf      # Subnet module outputs
    ├── ec2/
    │   ├── main.tf         # EC2 instance configuration
    │   ├── variables.tf    # EC2 module variables
    │   └── outputs.tf      # EC2 module outputs
    └── s3/
        ├── main.tf         # S3 bucket configuration
        ├── variables.tf    # S3 module variables
        └── outputs.tf      # S3 module outputs
```

## 🚀 Quick Start

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS CLI configured with appropriate credentials
- Appropriate IAM permissions for creating VPC, EC2, and S3 resources

### Initial Setup

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd terraform-modules-test
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Create and select workspace (optional):**
   ```bash
   # Create dev workspace (if not exists)
   terraform workspace new dev
   
   # Or select existing workspace
   terraform workspace select dev
   ```

4. **Plan and apply:**
   ```bash
   terraform plan
   terraform apply
   ```

## 🏷️ Resource Naming Convention

Resources are named using the following pattern:
- **Format:** `sree-{workspace}-{resource-type}`
- **Examples:**
  - Dev VPC: `sree-dev-vpc`
  - Prod Subnet: `sree-prod-subnet`
  - Dev EC2: `sree-dev-ec2`
  - Prod S3: `sree-prod-s3`

## 🌍 Workspace Management

This configuration supports multiple environments using Terraform workspaces:

### Available Workspaces

| Workspace | Environment | Description |
|-----------|-------------|-------------|
| `dev`     | Development | Development environment with relaxed security |
| `prod`    | Production  | Production environment with strict security |

### Workspace Commands

```bash
# List all workspaces
terraform workspace list

# Create a new workspace
terraform workspace new <workspace-name>

# Switch to a workspace
terraform workspace select <workspace-name>

# Show current workspace
terraform workspace show

# Delete a workspace (must be empty)
terraform workspace delete <workspace-name>
```

### Dev vs Prod Environment Scenarios

#### Development Environment (`dev` workspace)

**Characteristics:**
- Smaller instance types (cost optimization)
- More permissive S3 ACLs
- Single availability zone deployment
- Relaxed security groups (if configured)

**Usage:**
```bash
terraform workspace select dev
terraform plan -var="ec2_instance_type=t2.micro"
terraform apply
```

**Expected Resource Names:**
- VPC: `sre-dev-vpc`
- Subnet: `sre-dev-subnet`
- EC2: `sree-dev-EC2`
- S3: `sree-dev-terraform-test-bucket-{random}`

#### Production Environment (`prod` workspace)

**Characteristics:**
- Larger instance types (performance)
- Stricter S3 ACLs (`private` by default)
- Multi-availability zone capable
- Enhanced security configurations

**Usage:**
```bash
terraform workspace new prod
terraform workspace select prod
terraform plan -var="ec2_instance_type=t3.medium" -var="s3_acl=private"
terraform apply
```

**Expected Resource Names:**
- VPC: `sre-prod-vpc`
- Subnet: `sre-prod-subnet`
- EC2: `sree-prod-EC2`
- S3: `sree-prod-terraform-test-bucket-{random}`

## 📋 Configuration Variables

### Input Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `tag_prefix` | string | `"sree"` | Prefix for all resource names |
| `aws_region` | string | `"ap-south-1"` | AWS region for deployment |
| `ec2_ami` | string | `"ami-03f4878755434977f"` | AMI ID for EC2 instances |
| `ec2_instance_type` | string | `"t2.micro"` | EC2 instance type |
| `vpc_cidr` | string | `"10.0.0.0/16"` | CIDR block for VPC |
| `subnet_cidr` | string | `"10.0.1.0/24"` | CIDR block for subnet |
| `availability_zone` | string | `"ap-south-1a"` | Availability zone for subnet |
| `s3_acl` | string | `"private"` | Access control list for S3 bucket |

### Output Values

| Output | Description |
|--------|-----------|
| `vpc_id` | The ID of the created VPC |
| `subnet_id` | The ID of the created subnet |
| `ec2_instance_id` | The ID of the created EC2 instance |
| `s3_bucket_id` | The ID of the created S3 bucket |

## 🎯 Usage Examples

### Example 1: Deploy to Development

```bash
# Switch to dev workspace
terraform workspace select dev

# Deploy with dev-specific variables
terraform apply \
  -var="ec2_instance_type=t2.micro" \
  -var="s3_acl=public-read"
```

### Example 2: Deploy to Production

```bash
# Create and switch to prod workspace
terraform workspace new prod
terraform workspace select prod

# Deploy with prod-specific variables
terraform apply \
  -var="ec2_instance_type=t3.medium" \
  -var="vpc_cidr=10.1.0.0/16" \
  -var="subnet_cidr=10.1.1.0/24" \
  -var="s3_acl=private"
```

### Example 3: Using Variable Files

Create environment-specific `.tfvars` files:

**dev.tfvars:**
```hcl
ec2_instance_type = "t2.micro"
s3_acl = "public-read"
vpc_cidr = "10.0.0.0/16"
```

**prod.tfvars:**
```hcl
ec2_instance_type = "t3.medium"
s3_acl = "private"
vpc_cidr = "10.1.0.0/16"
subnet_cidr = "10.1.1.0/24"
```

```bash
# Apply with variable file
terraform apply -var-file="dev.tfvars"
```

## 🔒 Security Considerations

### Development Environment
- Use smaller instance types to minimize costs
- Consider more open security groups for testing
- Use public subnets for easier access
- S3 buckets can have relaxed ACLs for testing

### Production Environment
- Use appropriately sized instances for workload
- Implement strict security groups
- Use private subnets where possible
- Ensure S3 buckets have `private` ACL
- Enable encryption and logging
- Implement proper backup strategies

## 🧹 Cleanup

To destroy resources:

```bash
# Destroy resources in current workspace
terraform destroy

# Destroy specific workspace resources
terraform workspace select dev
terraform destroy
```

To remove workspaces:
```bash
# Switch to default workspace first
terraform workspace select default

# Delete the workspace
terraform workspace delete dev
```

## 🛠️ Troubleshooting

### Common Issues

1. **Workspace doesn't exist:**
   ```bash
   terraform workspace new <workspace-name>
   ```

2. **Resource naming conflicts:**
   - Ensure different workspaces use different CIDR blocks
   - S3 bucket names include random suffix to avoid conflicts

3. **AMI not available in region:**
   - Update `ec2_ami` variable with region-specific AMI ID

### Validation

Always validate your configuration:
```bash
terraform validate
terraform plan
```

## 📈 Next Steps

Consider implementing:
- [ ] Auto Scaling Groups for EC2
- [ ] Load Balancers for high availability
- [ ] RDS database instances
- [ ] CloudWatch monitoring
- [ ] Security Groups and NACLs
- [ ] IAM roles and policies
- [ ] Route53 DNS configuration

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `terraform plan`
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Author:** SREEDHAR 
**Last Updated:** September 2025  
**Terraform Version:** >= 1.0  
**AWS Provider Version:** >= 4.0

