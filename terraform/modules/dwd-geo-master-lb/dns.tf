#resource "oci_dns_zone" "zone" {
#    compartment_id = var.compartment_ocid
#    name = join(".", [var.dns_zone_name, var.dns_zone_parent])
#    zone_type = "PRIMARY"
#}

data "oci_dns_zones" "dwd-hub_zone" {
    #Required
    compartment_id = var.compartment_ocid

    #Optional
    name = var.dns_zone_parent
}

resource "oci_dns_rrset" "rrset_main" {
    domain = join(".", [var.dns_zone_name, var.dns_zone_parent])
    rtype = "CNAME"
    zone_name_or_id = var.dns_zone_parent
    items {
        domain = join(".", [var.dns_zone_name, var.dns_zone_parent])
        rdata = var.dns_initial_cname_pointer
        rtype = "CNAME"
        ttl = 30
    }
}

/*resource "oci_dns_rrset" "rrset_lb" {
    domain = join(".", ["geo-lb", var.dns_zone_name, var.dns_zone_parent])
    rtype = "A"
    zone_name_or_id = oci_dns_zone.zone.id
    items {
        domain = join(".", ["geo-lb", var.dns_zone_name, var.dns_zone_parent])
        rdata = oci_load_balancer_load_balancer.load_balancer.ip_address_details[0].ip_address
        rtype = "A"
        ttl = 30
    }
}*/