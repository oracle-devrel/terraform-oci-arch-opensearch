## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_vcn" "opensearch_vcn" {
  #provider       = oci.targetregion
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = var.vcn
  dns_label      = "opensearchvcn"
  #defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


resource "oci_core_internet_gateway" "internet_gateway" {
  #provider       = oci.targetregion
  compartment_id = var.compartment_ocid
  display_name   = "internet_gateway"
  vcn_id         = oci_core_vcn.opensearch_vcn.id
  #defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


resource "oci_core_nat_gateway" "nat_gateway" {
  #provider       = oci.targetregion 
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.opensearch_vcn.id
  display_name   = "nat_gateway"
  #defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


resource "oci_core_route_table" "public_route_table" {
  #provider       = oci.targetregion
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.opensearch_vcn.id
  display_name   = "RouteTableViaIGW"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
  #defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_route_table" "private_route_table" {
  #provider       = oci.targetregion
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.opensearch_vcn.id
  display_name   = "RouteTableViaNATGW"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
  #defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_security_list" "public_security_list_ssh" {
  #provider       = oci.targetregion
  compartment_id = var.compartment_ocid
  display_name   = "Public Security List"
  vcn_id         = oci_core_vcn.opensearch_vcn.id
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }
  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }
  #defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_security_list" "opensearch_security_list" {
  #provider       = oci.targetregion
  compartment_id = var.compartment_ocid
  display_name   = "Private"
  vcn_id         = oci_core_vcn.opensearch_vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
  ingress_security_rules {
    protocol = "1"
    source   = var.vcn_cidr
  }
  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }
    protocol = "6"
    source   = var.vcn_cidr
  }
  ingress_security_rules {
    tcp_options {
      max = 5601
      min = 5601
    }
    protocol = "6"
    source   = var.vcn_cidr
  }
  ingress_security_rules {
    tcp_options {
      max = 9200
      min = 9200
    }
    protocol = "6"
    source   = var.vcn_cidr
  }

  #defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_subnet" "opensearch_public_subnet" {
  #provider                   = oci.targetregion
  cidr_block                 = cidrsubnet(var.vcn_cidr, 8, 0)
  display_name               = "opensearch-public-subnet"
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.opensearch_vcn.id
  route_table_id             = oci_core_route_table.public_route_table.id
  security_list_ids          = [oci_core_security_list.public_security_list_ssh.id] 
  dhcp_options_id            = oci_core_vcn.opensearch_vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = false
  dns_label                  = "opensearchpub"
  #defined_tags               = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_subnet" "opensearch_private_subnet" {
  #provider                   = oci.targetregion
  cidr_block                 = cidrsubnet(var.vcn_cidr, 8, 1)
  display_name               = "opensearch-private-subnet"
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.opensearch_vcn.id
  route_table_id             = oci_core_route_table.private_route_table.id
  security_list_ids          = [oci_core_security_list.opensearch_security_list.id]
  dhcp_options_id            = oci_core_vcn.opensearch_vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = "true"
  dns_label                  = "opensearchpriv"
  #defined_tags               = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

