provider "openstack" {
    user_name  = "${var.user_name}"
    tenant_name = "${var.tenant_name}"
    password  = "${var.password}"
    auth_url  = "${var.auth_url}"
}

# we don't need the pub key with our golden image
/*
resource "openstack_compute_keypair_v2" "openshift" {
  name       = "openshift"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}
*/

resource "openstack_networking_network_v2" "openshift" {
  name           = "openshift"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "openshift" {
  name            = "openshift"
  network_id      = "${openstack_networking_network_v2.openshift.id}"
  cidr            = "10.0.0.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}

resource "openstack_networking_router_v2" "openshift" {
  name             = "openshift"
  admin_state_up   = "true"
  external_gateway = "${var.external_gateway}"
}

resource "openstack_networking_router_interface_v2" "openshift" {
  router_id = "${openstack_networking_router_v2.openshift.id}"
  subnet_id = "${openstack_networking_subnet_v2.openshift.id}"
}

resource "openstack_compute_secgroup_v2" "openshift" {
  name        = "openshift"
  description = "Security group for the Terraform example instances"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_floatingip_v2" "float1" {
  pool       = "${var.pool}"
  depends_on = ["openstack_networking_router_interface_v2.openshift"]
}


resource "openstack_compute_instance_v2" "master1" {
  name            = "master1"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  #key_pair        = "${openstack_compute_keypair_v2.openshift.name}"
  security_groups = ["${openstack_compute_secgroup_v2.openshift.name}"]
  floating_ip     = "${openstack_compute_floatingip_v2.float1.address}"

  network {
    uuid = "${openstack_networking_network_v2.openshift.id}"
  }
}

resource "openstack_compute_floatingip_v2" "float2" {
  pool       = "${var.pool}"
  depends_on = ["openstack_networking_router_interface_v2.openshift"]
}

resource "openstack_compute_instance_v2" "master2" {
  name            = "master2"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  #key_pair        = "${openstack_compute_keypair_v2.openshift.name}"
  security_groups = ["${openstack_compute_secgroup_v2.openshift.name}"]
  floating_ip     = "${openstack_compute_floatingip_v2.float2.address}"

  network {
    uuid = "${openstack_networking_network_v2.openshift.id}"
  }
}

resource "openstack_compute_floatingip_v2" "float3" {
  pool       = "${var.pool}"
  depends_on = ["openstack_networking_router_interface_v2.openshift"]
}

resource "openstack_compute_instance_v2" "master3" {
  name            = "master3"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  #key_pair        = "${openstack_compute_keypair_v2.openshift.name}"
  security_groups = ["${openstack_compute_secgroup_v2.openshift.name}"]
  floating_ip     = "${openstack_compute_floatingip_v2.float3.address}"

  network {
    uuid = "${openstack_networking_network_v2.openshift.id}"
  }
}

resource "openstack_compute_floatingip_v2" "float4" {
  pool       = "${var.pool}"
  depends_on = ["openstack_networking_router_interface_v2.openshift"]
}

resource "openstack_compute_instance_v2" "node1" {
  name            = "node1"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  #key_pair        = "${openstack_compute_keypair_v2.openshift.name}"
  security_groups = ["${openstack_compute_secgroup_v2.openshift.name}"]
  floating_ip     = "${openstack_compute_floatingip_v2.float4.address}"

  network {
    uuid = "${openstack_networking_network_v2.openshift.id}"
  }
}

resource "openstack_compute_floatingip_v2" "float5" {
  pool       = "${var.pool}"
  depends_on = ["openstack_networking_router_interface_v2.openshift"]
}

resource "openstack_compute_instance_v2" "node2" {
  name            = "node2"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  #key_pair        = "${openstack_compute_keypair_v2.openshift.name}"
  security_groups = ["${openstack_compute_secgroup_v2.openshift.name}"]
  floating_ip     = "${openstack_compute_floatingip_v2.float5.address}"

  network {
    uuid = "${openstack_networking_network_v2.openshift.id}"
  }
}

resource "openstack_compute_floatingip_v2" "float6" {
  pool       = "${var.pool}"
  depends_on = ["openstack_networking_router_interface_v2.openshift"]
}

resource "openstack_compute_instance_v2" "HAProxy" {
  name            = "HAProxy"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  #key_pair        = "${openstack_compute_keypair_v2.openshift.name}"
  security_groups = ["${openstack_compute_secgroup_v2.openshift.name}"]
  floating_ip     = "${openstack_compute_floatingip_v2.float6.address}"

  network {
    uuid = "${openstack_networking_network_v2.openshift.id}"
  }
}

resource "openstack_compute_instance_v2" "etcd1" {
  name            = "etcd1"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  #key_pair        = "${openstack_compute_keypair_v2.openshift.name}"
  security_groups = ["${openstack_compute_secgroup_v2.openshift.name}"]

  network {
    uuid = "${openstack_networking_network_v2.openshift.id}"
  }
}

resource "openstack_compute_instance_v2" "etcd2" {
  name            = "etcd2"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  #key_pair        = "${openstack_compute_keypair_v2.openshift.name}"
  security_groups = ["${openstack_compute_secgroup_v2.openshift.name}"]

  network {
    uuid = "${openstack_networking_network_v2.openshift.id}"
  }
}

resource "openstack_compute_instance_v2" "etcd3" {
  name            = "etcd3"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  #key_pair        = "${openstack_compute_keypair_v2.openshift.name}"
  security_groups = ["${openstack_compute_secgroup_v2.openshift.name}"]

  network {
    uuid = "${openstack_networking_network_v2.openshift.id}"
  }
}

