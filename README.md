# DevOps Infrastructure 
## AWS lab environment
## Features
* Bastion host as entrypoint to the lab infrastructure
* Reverse proxy for different web ports
* Infrastructure deployed with Terraform
* Applications deployed with Ansible

The bastion host uses an nginx reverse proxy for the lab hosts so that webservers running on the lab instances can be accessed.
Additionally, haproxy is used to also forward SSH connections based on the destination port.
The IP information of the lab instances as well as the port information for the haproxy and nginx reverse proxy is automatically created with Terraform.

Ansible uses the vault.yml where the Linus SSH password for the student user is defined. You have to create this file as well as the vault.pass file so that ansible can read the vault.yml file.

![Overview](https://github.com/fox27374/devops-infra/blob/main/aws_lab.png)