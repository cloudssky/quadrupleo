variable "user_name" {
   description = "The OpenStack Tenant user name"  
}

variable "tenant_name" {
   description = "The OpenStack Tenant name"  
}

variable "password" {
   description = "the user password"
}

variable "auth_url" {
   description = "the auth url"
}


variable "image" {
  default = "centos-snap-root-enabled-updated"
}

variable "flavor" {
  default = "m1.small"
}

variable "ssh_key_file" {
  default = "~/osxu.pub"
}

variable "ssh_user_name" {
  default = "root"
}

variable "external_gateway" {
  default= "f6bdeaa8-0a22-4266-84d0-f201865598a5"
}

variable "pool" {
  default = "ext_net"
}
