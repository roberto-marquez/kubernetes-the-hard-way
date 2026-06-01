locals {
  private_ips = {
    jumpbox = "10.0.101.10"
    server  = "10.0.1.11"
    node0  = "10.0.1.12"
    node1  = "10.0.1.13"
  }

  hosts_file = join("\n", [
    for name, ip in local.private_ips : "${ip} ${name}"
  ])

}
