# Terraform Script for Hetzner Cloud

This project contains a Terraform script for setting up a server on Hetzner Cloud, including the creation of a private network and firewall with certain ports open.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.7.5 installed
- Hetzner Cloud Token
- SSH Private Key

## Steps

1. Clone this repository: `git clone https://link-to-this-repo`
2. Navigate into the project directory: `cd directory-name`
3. Rename `terraform.tfvars.example` to `terraform.tfvars`: `mv terraform.tfvars.example terraform.tfvars`
4. Open `terraform.tfvars` and replace the example values with your actual Hetzner Cloud token and ssh key details.
5. Initialize Terraform: `terraform init`
6. Plan the infrastructure: `terraform plan`
7. Apply the infrastructure: `terraform apply`

After completion, Terraform will create a new Hetzner Cloud server with specific network and firewall rules.

## Generating an SSH Key Pair

If you do not have an SSH key pair, you can generate one using the following command:

```bash
ssh-keygen -t rsa -b 4096 -C "your-email@example.com" -f ~/.ssh/your_key_name
```

This will create a new SSH key pair in your `~/.ssh` directory.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details