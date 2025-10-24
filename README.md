# DevOps Infrastructure 
## AWS lab environment
A fully automated lab environment designed to support Linux, container, Kubernetes, and other Linux-based application training scenarios. The entire environment can be deployed and configured through automation, with infrastructure settings defined in **tfvars** files and configuration management handled via **main.yml** files within Ansible playbooks or role directories.

## Features
* Bastion host serving as a secure SSH entry point to the lab environment
* Apache Guacamole server (running on k3s) providing web-based access to lab resources
* AWS Load Balancer enabling external access to hosted web applications
* Fine grained network ACLs leveraging security groups
* Infrastructure provisioned using Terraform
* Application deployment automated with Ansible
* Splunk monitoring server (running on k3s) for in depth monitoring of the labs
* Opentelemetry collector used for metrics and logs

## Prerequisites
1) Configure your local **~/.aws/config** and **~/.aws/credentials** files to ensure the Terraform AWS provider can authenticate with your AWS account.
2) Update the **terraform.tfvars** file according to your requirements, especially the number of private instances to be deployed.
3) Replace the public key in **terraform/cloud-config/user_data.cloud** with your own.
4) Rename **ansible/vault_template.yml** to **vault.yml** and encrypt it using ansible-vault.

## Lab usage
Currently there are two labs that can be deployed and used for trainings. A container lab and a kubernetes lab.
The files that are copied by Ansible can be found in the lab role in the **files** directory. This can be switched off by setting the **copy_lab_files** to **false** in the **main.yml**.

Trainings based on this lab infrastructure:
* [Linux Basics](https://github.com/fox27374/linux-basics)
* [Container Basics](https://github.com/fox27374/container-basics)
* [DevOps Workshop](https://github.com/fox27374/devops-workshop)  

![Overview](https://github.com/fox27374/devops-infra/blob/main/aws_lab.png)