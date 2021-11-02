resource "aws_customer_gateway" "this" {
  bgp_asn     = var.bgp_asn
  ip_address  = var.ip_addr
  type        = var.type
  device_name = var.device_name

  tags = merge(
    {
      "Name" = format("%s-cgw", var.cgw_name)
    },
    local.common_tags,
  )
}
