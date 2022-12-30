terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "4.100.0"
    }
  }
}
provider "oci"  {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

#Step-1 Create Root Compartment
resource "oci_identity_compartment" "my-root_compartment" {
    compartment_id = var.compartment_id
    description = "This is a Root Compartment"
    name = "My_Root_compartment"
}

#Step-2 Create Child Compartment
resource "oci_identity_compartment" "my-test_compartment" {
    compartment_id = oci_identity_compartment.my-root_compartment.id
    description = "This compartment is for testing"
    name = "My_compartment"
}

#Step-3 Create DRG 
resource "oci_core_drg" "my-test_drg" {
    compartment_id = oci_identity_compartment.my-test_compartment.id
    display_name = var.drg_display_name
}

#Step-4 Create VCN
resource "oci_core_vcn" "my-test_vcn" {
    compartment_id = oci_identity_compartment.my-test_compartment.id
    cidr_blocks = var.vcn_cidr_blocks
    display_name = var.vcn_display_name
}

#Step-5 Connect VCN with DRG
resource "oci_core_drg_attachment" "drg_to_vcn_attachment" {
    drg_id = oci_core_drg.my-test_drg.id
    vcn_id = oci_core_vcn.my-test_vcn.id
}

#Step-6 Create Subnet for VCN
resource "oci_core_subnet" "my-test_subnet" {
    cidr_block = var.subnet_cidr_block
    compartment_id = oci_identity_compartment.my-test_compartment.id
    vcn_id = oci_core_vcn.my-test_vcn.id
}

#Step-6 Add New Route table on VCN
resource "oci_core_route_table" "test_route_table" {
    #Required
    compartment_id = oci_identity_compartment.my-test_compartment.id
    vcn_id = oci_core_vcn.my-test_vcn.id
    display_name   = "my_Route_Table"
    route_rules {
        network_entity_id = oci_core_drg.my-test_drg.id
        destination = var.route_table_route_rules_destination
        destination_type = var.route_table_route_rules_destination_type
    }
}
#Step-6 Add New Security List on VCN
resource "oci_core_security_list" "my_security_list" {
  compartment_id = oci_identity_compartment.my-test_compartment.id
  display_name   = "my_security_list"
  vcn_id         = oci_core_vcn.my-test_vcn.id

  # Allow outbound traffic
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  # Allow inbound traffic
  ingress_security_rules {
    protocol = "6"
    source   = var.secerity_list_cidr_blocks

    tcp_options {
      min = 2048
      max = 2050
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.secerity_list_cidr_blocks

    tcp_options {
        min = 1010
        max = 1050
      source_port_range {
        min = 2048
        max = 2050
      }
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.secerity_list_cidr_blocks

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {  
    protocol = 1
    source   = "0.0.0.0/0"

    icmp_options {
      type = 3
    }
  }
}

# resource "oci_core_instance" "test_instance" {
#     count = var.instance_count
#     availability_domain = var.availability_domain
#     display_name = "My_compute_instance"
#     state = var.instance_state
#     compartment_id = oci_identity_compartment.my-test_compartment.id
#     shape = var.shape

#     source_details {
#     boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
# #     source_id               = var.source_ocid
# #     source_type             = var.source_type
# # }
# }
#======================================================================================================================
#resource "oci_core_image" "test_image" {
    #Required
    #compartment_id = oci_identity_compartment.my-test_compartment.id
    #instance_id = oci_core_instance.test_instance.id
#}

#resource "oci_core_drg" "test_drg" {
    #Required
    #compartment_id = var.compartment_id
#}
#}

