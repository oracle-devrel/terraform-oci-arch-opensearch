## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}

variable "release" {
  default = "1.0"
}

variable "ssh_public_key" {
  default = ""
}

variable "availability_domain_name" {
  default = ""
}

variable "tenancy_ocid" {
  description = "Tenancy OCID"
}

variable "compartment_ocid" {
  description = "OCID of the compartment where VCN will be created"
}

variable "region" {
  description = "OCI Region"
}

variable "vcn" {
  description = "VCN Name"
  default     = "opensearch-vcn"
}

variable "vcn_cidr" {
  description = "VCN's CIDR IP Block"
  default     = "10.0.0.0/16"
}

variable "node_image_id" {
  description = "The OCID of an image for a node instance to use."
  default     = ""
}

variable "node_shape" {
description = "Instance shape to use for master instance."
 default     = "VM.Standard.E4.Flex"
}

variable "node_flex_shape_ocpus" {
  description = "Flex Instance shape OCPUs"
  default = 1
}

variable "node_flex_shape_memory" {
  description = "Flex Instance shape Memory (GB)"
  default = 6
}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "9"
}

variable "ssh_authorized_keys" {
  description = "Public SSH keys path to be included in the ~/.ssh/authorized_keys file for the default user on the instance. DO NOT FILL WHEN USING RESOURCE MANAGER STACK!"
  default     = ""
}

variable "ssh_private_key_path" {
  description = "The private key path to access instance. DO NOT FILL WHEN USING RESOURCE MANAGER STACK!"
  default     = ""
}

variable "vm_instance_name" {
  description = "Name of the compute instance"
  default     = "opensearch-instance"
}

variable "opensearch_cluster_data_node_count" {
  default = 1
}

variable "opensearch_cluster_data_node_host_memory_gb" {
  default = 20
}

variable "opensearch_cluster_data_node_host_ocpu_count" {
  default = 4
}

variable "opensearch_cluster_data_node_host_type" {
  default = "FLEX"
}

variable "opensearch_cluster_data_node_storage_gb" {
  default = 50
}

variable "opensearch_cluster_display_name" {
  default = "opencluster"
}

variable "opensearch_cluster_master_node_count" {
  default = 1
}

variable "opensearch_cluster_master_node_host_memory_gb" {
  default = 16
}

variable "opensearch_cluster_master_node_host_ocpu_count" {
  default = 1
}

variable "opensearch_cluster_master_node_host_type" {
  default = "FLEX"
}

variable "opensearch_cluster_opendashboard_node_count" {
  default = 1
}

variable "opensearch_cluster_opendashboard_node_host_memory_gb" {
  default = 16
}

variable "opensearch_cluster_opendashboard_node_host_ocpu_count" {
  default = 1
}

variable "opensearch_cluster_software_version" {
  default = "1.2.4"
}

