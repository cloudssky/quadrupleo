resource "openstack_compute_secgroup_v2" "openshift" {
  name        = "openshift"
  description = "Security group for OpenShift instances"

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
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 53
    to_port     = 53
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 8053
    to_port     = 8053
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 53
    to_port     = 53
    ip_protocol = "udp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 8053
    to_port     = 8053
    ip_protocol = "udp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 1936
    to_port     = 1936
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 4001
    to_port     = 4001
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 2379
    to_port     = 2379
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 2380
    to_port     = 2380
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 4789
    to_port     = 4789
    ip_protocol = "udp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 8443
    to_port     = 8443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 10250
    to_port     = 10250
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

