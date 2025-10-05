# Terraform Project: Launch CentOS Stream 10 EC2 in Custom VPC

## Overview

This Terraform project demonstrates how to launch a **CentOS Stream 10 EC2 instance** in AWS using a **custom VPC**. The project dynamically generates an **SSH key pair**, creates a **security group**, and provisions a **public subnet** for the EC2 instance.

**Tech Stack:** Terraform, AWS EC2, AWS VPC, SSH key pair

**Region:** us-east-1

---

## Project Structure

```
terraform-centos-ec2/
├── main.tf       # Main resources (VPC, subnet, SG, EC2, key pair)
├── variables.tf  # Variables for region, instance type, and tags
├── provider.tf   # AWS provider configuration
├── outputs.tf    # Outputs for EC2 public IP, instance ID, and key file path
```

---

## Step-by-Step Guide

### Step 1: Clone/Create Project Folder

```powershell
mkdir terraform-centos-ec2
cd terraform-centos-ec2
```

### Step 2: Add Terraform Configuration Files

* `provider.tf` → AWS provider configuration.
* `variables.tf` → Define variables for region, instance type, and tags.
* `main.tf` → Create VPC, public subnet, security group, generate SSH key, and launch EC2 instance.
* `outputs.tf` → Display instance details.

### Step 3: Initialize Terraform

```powershell
terraform init
```

### Step 4: Plan the Deployment

```powershell
terraform plan
```

### Step 5: Apply the Configuration

```powershell
terraform apply -auto-approve
```

Terraform will:

* Create a custom VPC
* Create a public subnet
* Generate an SSH key pair
* Create a security group
* Launch a CentOS Stream 10 EC2 instance
* Save the private key locally as `terraform-ec2-key.pem`

### Step 6: Verify Outputs

```powershell
terraform output
```

Sample output:

```
instance_id = "i-0abcd1234efgh5678"
public_ip = "3.91.56.100"
private_key_file = "C:/path/to/terraform-centos-ec2/terraform-ec2-key.pem"
```

### Step 7: SSH into EC2 Instance

```bash
ssh -i terraform-ec2-key.pem ec2-user@<public_ip>
```

* `ec2-user` is the default user for CentOS
* `<public_ip>` comes from `terraform output public_ip`

### Step 8: Destroy Resources

```powershell
terraform destroy -auto-approve
```

This will clean up all resources created by Terraform.

---

## Key Features

* **Custom VPC & Subnet:** No dependency on default VPC.
* **Dynamic SSH Key Generation:** Terraform generates and saves private key automatically.
* **Security Group:** Allows SSH access from anywhere.
* **CentOS Stream 10 AMI:** Fixed AMI ID for `us-east-1` ensures reliable deployment.
* **Outputs:** Public IP, instance ID, and private key path for easy SSH access.

---

## Variables (variables.tf)

```hcl
variable "aws_region" {
  description = "AWS region to launch EC2 instance"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
  default = {
    Project = "terraform-centos-ec2"
    Owner   = "Nikki"
  }
}
```

---

## Notes

* Ensure your AWS account has permissions to create VPCs, subnets, security groups, key pairs, and EC2 instances.
* The private key (`terraform-ec2-key.pem`) must have proper permissions (`chmod 400 terraform-ec2-key.pem`) before SSH.
* This setup works even if your AWS account has **no default VPC**.

---

## References

* [CentOS Stream 10 AMIs](https://www.centos.org/download/aws-images/)
* [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Terraform TLS Provider](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key)
