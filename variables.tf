#
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
  description = "your image name"
}

variable "flavor" {
  default = "m1.small"
}


/*
variable "ssh_key_file" {
  default = "~/key.pub"
}
*/

variable "ssh_user_name" {
  default = "root"
}

variable "external_gateway" {
  description = "the id of your external gateway"
}

variable "pool" {
  description = "external folating ip pool"
  #default = "public"
}
