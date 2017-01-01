<h1>QuadrupleO</h1>

OpenShift Origin On OpenStack with Terraform and Ansible Anywhere

Please refer to: https://goo.gl/gbnMDD

With Terraform you can spin up your master, worker and etcd nodes on OpenStack within 1-2 minutes. You can install Terraform by following this link. 

The following script from our quadrupleo Github Repo deploys 9 nodes (3 masters, 2 worker nodes, 3 etcds and the LB (HAProxy)) with a new network “openshift”, subnets, router, security group, etc. on your OpenStack cloud .You can adjust this script as you need, by simply commenting out the masters, nodes and HAProxy or other resources such as floatingIps, etc.

Note: this script doesn’t add any volumes to the hosts yet.

You can checkout the scripts from Github:

$ git clone https://github.com/cloudssky/quadrupleo.git
$ cd quadrupleo/
$ cp terraform.tfvars.sample terraform.tfvars

And provide the right values for your OpenStack environment terraform.tfvars file (keep this file in a safe place):

$ vi terraform.tfvars

user_name = "your user name"
tenant_name = "your tenant name"
password= "your password"
auth_url = "http://<your ip/ domain>:5000/v2.0"
external_gateway = "the id of your external gateway"
image = "your image name"
pool = "external floating ip pool. default is public"

Check your plan:

# show your plan
$ terraform plan

# save your plan
$ terraform plan -out quadrupleo-`date +'%s'`.plan

Provision your Origin base cluster

Now you’re ready to provision your base cluster in less than one minute:

$ terraform apply

$ terraform show


In Horizon, under Network Topology, you should see something similar to this:


# destroy your cluster (use it with caution!!!!!)
$ terraform destroy

To create the Terraform Graph, you might want to use:

$ terraform graph > openshift.dot
$ dot openstack.dot -Tsvg -o openshift.svg

You’ll get something similar to this (only to show how terraform rocks):

