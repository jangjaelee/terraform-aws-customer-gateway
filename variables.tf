variable "cgw_name" {
  description = "Name to be used on all the resources as identifier for Customer Gateway"
  type        = string
}

variable "bgp_asn" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)"
  type        = number
}

variable "ip_addr" {
  description = "The IP address of the gateway's Internet-routable external interface"
  type        = string
}

variable "type" {
  description = "The type of customer gateway. The only type AWS supports at this time is ipsec.1"
  type        = string
  default     = "ipsec.1"
}

variable "device_name" {
  description = "A name for the customer gateway device"
  type        = string
  default     = ""
}

variable "env" {
  description = "Environment"
  type        = string
}
