## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_opensearch_opensearch_cluster" "my_opensearch_cluster" {

    #Required
    compartment_id = var.compartment_ocid
    data_node_count = var.opensearch_cluster_data_node_count
    data_node_host_memory_gb = var.opensearch_cluster_data_node_host_memory_gb
    data_node_host_ocpu_count = var.opensearch_cluster_data_node_host_ocpu_count
    data_node_host_type = var.opensearch_cluster_data_node_host_type
    data_node_storage_gb = var.opensearch_cluster_data_node_storage_gb
    display_name = var.opensearch_cluster_display_name
    master_node_count = var.opensearch_cluster_master_node_count
    master_node_host_memory_gb = var.opensearch_cluster_master_node_host_memory_gb
    master_node_host_ocpu_count = var.opensearch_cluster_master_node_host_ocpu_count
    master_node_host_type = var.opensearch_cluster_master_node_host_type
    opendashboard_node_count = var.opensearch_cluster_opendashboard_node_count
    opendashboard_node_host_memory_gb = var.opensearch_cluster_opendashboard_node_host_memory_gb
    opendashboard_node_host_ocpu_count = var.opensearch_cluster_opendashboard_node_host_ocpu_count
    software_version = var.opensearch_cluster_software_version

    subnet_compartment_id = var.compartment_ocid
    subnet_id = oci_core_subnet.opensearch_private_subnet.id
    vcn_compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.opensearch_vcn.id

    #Optional
    #defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
