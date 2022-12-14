## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "opensearch_vm_public_ip" {
  value = oci_core_instance.opensearch_instance.public_ip
}

output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

output "generated_ssh_public_key" {
  value     = tls_private_key.public_private_key_pair.public_key_openssh
  sensitive = true
}

output "opensearch_api_endpoint" {
  value = oci_opensearch_opensearch_cluster.my_opensearch_cluster.opensearch_fqdn != null ? "${oci_opensearch_opensearch_cluster.my_opensearch_cluster.opensearch_fqdn}:9200" : null
}

output "opensearch_dashboards_api_endpoint" {
  value = oci_opensearch_opensearch_cluster.my_opensearch_cluster.opendashboard_fqdn != null ? "${oci_opensearch_opensearch_cluster.my_opensearch_cluster.opendashboard_fqdn}:5601" : null
}