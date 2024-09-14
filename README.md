# VulnLab: Vulnerability Lab Environment

## Overview

The **VulnLab** project sets up a vulnerability lab environment on DigitalOcean using Terraform. It provisions a DigitalOcean droplet with an initial setup script that configures various services and security settings for vulnerability testing.

## Prerequisites

Before you start, ensure you have the following:

- **Terraform:** [Install Terraform](https://www.terraform.io/downloads.html) if you haven't already.
- **DigitalOcean Account:** [Create a DigitalOcean account](https://www.digitalocean.com/) and generate an API token.
- **SSH Key:** Ensure you have an SSH key pair available for secure access to your droplet.

## Getting Started

### 1. Clone the Repository

Clone this repository to your local machine:

```sh
git clone <repository-url>
cd vulnlab
```
2. Configure Your Environment
Create a file named terraform.tfvars in the project directory and add the following content:
```
do_token = "your_digitalocean_api_token"
ssh_private_key_path = "path_to_your_ssh_private_key"
```

2. Configure Your Environment
Create a file named terraform.tfvars in the project directory and add the following content:
```
do_token = "your_digitalocean_api_token"
ssh_private_key_path = "path_to_your_ssh_private_key"
```
Replace your_digitalocean_api_token with your actual DigitalOcean API token, and path_to_your_ssh_private_key with the path to your SSH private key.

3. Review the Installation Script
The Terraform configuration includes a script (vulnlab.sh) that will be executed when the droplet is created. Review and modify this script if necessary. It is located in the project directory and contains commands to set up your environment.

4. Initialize Terraform
Run terraform init to initialize the Terraform working directory and download the required providers:
```
terraform init
```
5. Plan Your Deployment
Run terraform plan to see what Terraform intends to create:
```
terraform plan
```
7. Apply the Configuration
Run terraform apply to create the DigitalOcean droplet and other resources:
```
terraform apply -auto--approve
```
8. Access Your Droplet
Once the deployment is complete, Terraform will output the IP address of the newly created droplet. Use this IP address to SSH into the droplet:
```
ssh root@<droplet_ip>
```
Replace <droplet_ip> with the IP address provided by Terraform.

9. Verify the Setup
After logging into your droplet, verify that the installation script executed correctly. Check the installed services and configurations based on the script.

Check if docker is installed and running
```
systemctl status docker
```

## Troubleshooting

Authentication Errors: Ensure that your DigitalOcean API token is correct and has the necessary permissions.

Script Execution Issues: Check the droplet’s cloud-init logs for errors:
```
sh
Copy code
cat /var/log/cloud-init.log
Provider Errors: Make sure you are using the correct provider version and configuration.
```
Clean Up
To destroy the resources created by Terraform, run:
```
Copy code
terraform destroy
Confirm the destruction by typing yes when prompted.
```

Contributing
If you have any improvements or bug fixes, feel free to contribute by creating a pull request. Ensure that your contributions align with the project’s goals and coding standards.

License
This project is licensed under the MIT License. See the LICENSE file for details.
