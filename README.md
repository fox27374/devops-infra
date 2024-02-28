# DevOps Infrastructure 
## AWS lab environment
## Features
* Bastion host as entrypoint to the lab infrastructure
* Reverse proxy to access webservers in the lab environment
* Infrastructure deployed with Terraform
* Applications deployed with Ansible

The bastion host uses an nginx reverse proxy for the lab hosts so that webservers running on the lab instances can be accessed.
Additionally, haproxy is used to also forward SSH connections based on the destination port.
The IP information of the lab instances as well as the port information for the haproxy and nginx reverse proxy is automatically created with Terraform.

Actions before deploying:

1) Setup your local **./aws/config** and **./aws/credentials** files so that the terraform provider can access your AWS tenant.
2) Adept the **terraform.tfvars** file to your needs, espececially the number of private instances.
3) Change the public key in **terraform/cloud-config/user_data.cloud**.
4) Adept the ansible variable for the student role **ansible/student/defaults/main.yml** and the variables **ansible/student/vars/main.yml**.

The files that are copied by Ansible are needed for the lab in this [repository](https://github.com/fox27374/devops-workshop), so just set the **copy_lab_files** to **false** if you dont need them.

![Overview](https://github.com/fox27374/devops-infra/blob/main/aws_lab.png)