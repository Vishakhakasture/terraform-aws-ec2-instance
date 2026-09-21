# Terraform AWS EC2 Instance

This project demonstrates how to use **Terraform** to create an Amazon EC2 instance in an AWS account. The Terraform code was written and executed locally using Visual Studio Code.

## Project Overview

In this project, Terraform is used to provision an EC2 instance on AWS using Infrastructure as Code (IaC).

The main steps involved are:

* Configure AWS as the Terraform provider
* Write Terraform configuration for an EC2 instance
* Initialize Terraform
* Validate and format the configuration
* Create an execution plan
* Deploy the EC2 instance to AWS
* Verify the instance in the AWS Console
* Destroy the infrastructure when it is no longer required

## Technologies Used

* Terraform
* Amazon Web Services (AWS)
* Amazon EC2
* Visual Studio Code
* AWS CLI

## Project Structure

```text
terraform-aws-ec2/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
└── README.md
```

## Prerequisites

Before running this project, make sure you have:

* An active AWS account
* Terraform installed
* AWS CLI installed
* Visual Studio Code installed
* Appropriate IAM permissions to create EC2 resources

Check Terraform installation:

```bash
terraform -version
```

Check AWS configuration:

```bash
aws sts get-caller-identity
```

## AWS Configuration

Configure your AWS credentials using the AWS CLI:

```bash
aws configure
```

Enter the required information:

```text
AWS Access Key ID
AWS Secret Access Key
Default region name
Default output format
```

Note: Never upload AWS credentials or secret keys to GitHub.

## Terraform Configuration

The AWS provider can be configured in `main.tf`:

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

Example EC2 resource:

```hcl
resource "aws_instance" "example" {
  ami           = "YOUR_AMI_ID"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-EC2"
  }
}
```

Replace `YOUR_AMI_ID` with a valid AMI ID available in your selected AWS region.

## Deployment Steps

### 1. Clone the Repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
```

Navigate to the project directory:

```bash
cd terraform-aws-ec2
```

### 2. Initialize Terraform

```bash
terraform init
```

This initializes the Terraform working directory and downloads the required provider plugins.

### 3. Validate Terraform Configuration

```bash
terraform validate
```

This checks whether the Terraform configuration is valid.

### 4. Format Terraform Code

```bash
terraform fmt
```

This formats the Terraform files using the standard Terraform formatting style.

### 5. Create Terraform Plan

```bash
terraform plan
```

This shows the resources Terraform plans to create, modify, or destroy.

### 6. Create the EC2 Instance

```bash
terraform apply
```

When prompted for confirmation, enter:

```text
yes
```

Terraform will create the EC2 instance in the AWS account.

## Verify EC2 Instance

After `terraform apply` completes successfully:

1. Log in to the AWS Management Console.
2. Open the **EC2** service.
3. Go to **Instances**.
4. Verify that the EC2 instance created by Terraform is available.

## Terraform Outputs

If outputs are configured in `outputs.tf`, they can be displayed using:

```bash
terraform output
```

Example:

```hcl
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
```

## Destroy Resources

When the EC2 instance is no longer required, destroy the infrastructure using:

```bash
terraform destroy
```

Confirm the operation by entering:

```text
yes
```

This will remove the resources managed by Terraform from the AWS account.

## Terraform Workflow

```text
Write Terraform Code
        ↓
terraform init
        ↓
terraform validate
        ↓
terraform fmt
        ↓
terraform plan
        ↓
terraform apply
        ↓
EC2 Instance Created
        ↓
Verify in AWS Console
        ↓
terraform destroy
```

## Security Best Practices

* Never commit AWS access keys or secret keys to GitHub.
* Do not commit Terraform state files.
* Do not store sensitive information directly in Terraform code.
* Use IAM permissions according to the principle of least privilege.
* Keep sensitive `.tfvars` files out of GitHub.

Example `.gitignore`:

```gitignore
.terraform/
*.tfstate
*.tfstate.*
crash.log
crash.*.log
*.tfvars
*.tfvars.json
.DS_Store
Thumbs.db
```

## What I Learned

Through this project, I learned:

* Basics of Terraform
* Infrastructure as Code (IaC)
* AWS provider configuration
* Creating an EC2 instance using Terraform
* Terraform initialization and validation
* Using `terraform plan`
* Using `terraform apply`
* Managing infrastructure using Terraform
* Destroying AWS resources using Terraform
