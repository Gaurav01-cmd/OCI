variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_id" {}
variable "namespace" {}
variable "drg_display_name" {}
variable "subnet_cidr_block" {}
variable "vcn_display_name" {}
variable "availability_domain" {}
variable "vcn_cidr_blocks" {}
variable "route_table_route_rules_destination"{}
variable "route_table_route_rules_destination_on_prem"{}
variable "route_table_route_rules_destination_type"{}
variable "security_list_cidr_blocks"{}
#variable "instance_console_connection_public_key_path" {}
variable "image_ocid" {
  default="ocid1.image.oc1.ap-mumbai-1.aaaaaaaafdhnwn64wnw3c2v4xabp6jgwtvvvdz6ypqpeyz36kqxmr3fdcuta"
}
variable "load_balancer_display_name" {
  default="My-LB"
}


variable "load_balancer_shape_details_maximum_bandwidth_in_mbps" {
  default="10"
}

variable "load_balancer_shape_details_minimum_bandwidth_in_mbps" {
  default="10"
}

#variable "instance_console_connection_public_key_path" {
  #default = "H:/Terraform-Project/ssh-key-2023-02-09.pub"
#}

variable "path_local_public_ke" {
 default = "H:/Terraform-Project/instance-publi.pub"
  sensitive = true
}

variable "path_local_private_ke" {
 default = "H:/Terraform-Project/instance-private"
  sensitive = true
}




# variable "instance_count" {
#   description = "Number of identical instances to launch from a single module."
#   type        = number
#   default     = 1
# }
# variable "instance_state" {
#   type        = string
#   description = "(Updatable) The target state for the instance. Could be set to RUNNING or STOPPED."
#   default     = "RUNNING"

#   validation {
#     condition     = contains(["RUNNING", "STOPPED"], var.instance_state)
#     error_message = "Accepted values are RUNNING or STOPPED."
#   }
# }
# variable "shape" {
#   description = "The shape of an instance."
#   type        = string
#   default     = "VM.Standard.E2.1.Micro"
# }
# variable "boot_volume_size_in_gbs" {
#   description = "The size of the boot volume in GBs."
#   type        = number
#   default     = null
# }

# variable "source_ocid" {
#   description = "The OCID of an image or a boot volume to use, depending on the value of source_type."
#   type        = string
# }

# variable "source_type" {
#   description = "The source type for the instance."
#   type        = string
#   default     = "image"
# }
