# Terraform EC2 Instance Project

This is a simple Terraform project to launch an **Amazon EC2 instance** running **Amazon Linux 2** with **Apache installed**. It includes a security group allowing SSH and HTTP access and demonstrates Terraform outputs for public IP, DNS, and web URL.

---

## **Prerequisites**

1. Terraform installed (v0.13+; tested with 1.13).  
2. AWS CLI configured with appropriate IAM permissions.  
3. Internet access to download Terraform providers.  

---

## **Project Structure**

```
terraform-ec2/
├── provider.tf       # Terraform provider configuration
├── variables.tf      # Input variables
├── main.tf           # EC2 and Security Group resources
├── user_data.sh      # EC2 bootstrap script to install Apache
└── outputs.tf        # Terraform outputs
```

---

## **Step 1: Create an EC2 Key Pair**

Run the following commands to create a key pair and set permissions:

```bash
aws ec2 create-key-pair --key-name MyKey --query 'KeyMaterial' --output text > MyKey.pem
chmod 400 MyKey.pem
```

> Keep `MyKey.pem` safe. You will need it to SSH into the EC2 instance.

---

## **Step 2: Initialize Terraform**

```bash
terraform init
```

- Downloads required provider plugins.  
- Prepares the working directory for Terraform operations.  

---

## **Step 3: Plan**

```bash
terraform plan -var="key_name=MyKey"
```

- Review the resources Terraform will create.  
- Ensure the `key_name` matches the key you created (`MyKey`).  

---

## **Step 4: Apply**

```bash
terraform apply -var="key_name=MyKey" -auto-approve
```

- Creates the EC2 instance, security group, and deploys Apache automatically via `user_data.sh`.

---

## **Step 5: View Outputs**

```bash
terraform output
```

You will see:

- `instance_id` → EC2 instance ID  
- `public_ip` → Public IP of the instance  
- `public_dns` → Public DNS name  
- `web_url` → HTTP URL to access your test Apache page  

Open the `web_url` in a browser to see your “Hello from Terraform EC2” page.

---

## **Step 6: SSH into the Instance**

```bash
ssh -i MyKey.pem ec2-user@<public_ip>
```

- `ec2-user` is the default username for Amazon Linux 2.  
- Replace `<public_ip>` with the value from `terraform output public_ip`.

---

## **Step 7: Destroy Resources**

```bash
terraform destroy -var="key_name=MyKey" -auto-approve
```

- Cleans up all AWS resources created by Terraform.  
- Recommended to avoid unnecessary charges.

---

## **Notes**

- Security: In production, **restrict SSH access** by setting `allowed_ssh_cidr` to your IP only.  
- The `user_data.sh` script installs and starts Apache and creates a test HTML page.  
- This project can be reused as a **module** for multiple EC2 instances with minor modifications.  

