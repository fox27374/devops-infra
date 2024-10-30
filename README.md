# DevOps Infrastructure 
## AWS lab environment
## Features
* Bastion host as entrypoint to the lab infrastructure
* Guacamole server to access the lab servers
* Reverse proxy to access webservers in the lab environment
* Infrastructure deployed with Terraform
* Applications deployed with Ansible

The bastion host uses Apache Guacamole to be able to access the lab resources on port 22 with any webbrowser.
Additionally, an nginx reverseproxy is used to access the lab servers on port 80.
The IP information of the lab instances as well as the port information the nginx reverse proxy is automatically created with Terraform.
Guacamole, docker and k3s are deployed with Ansible.

Actions before deploying:

1) Setup your local **./aws/config** and **./aws/credentials** files so that the terraform provider can access your AWS tenant.
2) Adept the **terraform.tfvars** file to your needs, espececially the number of private instances.
3) Change the public key in **terraform/cloud-config/user_data.cloud**.
4) Rename the **ansible/vault_template.yml** to **vault.yaml** and encrypt it with ansible-vault.

## Role description
TODO

The files that are copied by Ansible are needed for the lab in this [repository](https://github.com/fox27374/devops-workshop), so just set the **copy_lab_files** to **false** if you dont need them.

![Overview](https://github.com/fox27374/devops-infra/blob/main/aws_lab.png)