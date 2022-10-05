## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_identity_policy" "OpenSearchPolicy" {
  provider       = oci.homeregion
  name           = "OpenSearchPolicy-${random_id.tag.hex}"
  description    = "This policy is created for the OCI Search Service with OpenSearch to be able to use other services and vice-versa"
  compartment_id = var.compartment_ocid
  statements = [
    "Allow service opensearch to manage vcns in compartment id ${var.compartment_ocid}",
    "Allow service opensearch to manage vnics in compartment id ${var.compartment_ocid}",
    "Allow service opensearch to use subnets in compartment id ${var.compartment_ocid}",
    "Allow service opensearch to use network-security-groups in compartment id ${var.compartment_ocid}"]

  provisioner "local-exec" {
    command = "sleep 5"
  }
}