cluster_name = "production"

project_id = "dvntest-380216"

masters_cidr = "10.0.64.0/28" # /28 CIDR is mandatory

network_name = "production" # Avoiding use default VPC

subnets = {
  nodes    = "10.0.1.0/24"
  pods     = "10.1.0.0/16" # lots of pods ip addrs
  services = "10.2.0.0/16" # lots of services ip addrs
}

pools_map = {
  default = {
    machine_type = "e2-small" # Cheaper machines
    disk_size    = "12"       # Cheaper disks
    labels = {
      cloud  = "gcp"
      region = "eu"
      pool   = "default"
    }
    tags        = {}
    preemptible = true
    zones = [
      "europe-southwest1-a",
      "europe-southwest1-b",
      "europe-southwest1-c"
    ]
    autoscaling = {
      min = 1
      max = 3
    }
  }
}

k8s_namespaces = {
  apps = {
    labels      = {}
    annotations = {}
  }
  cert-manager = {
    labels      = {}
    annotations = {}
  }
}

timezone = "Europe/Madrid"

region = "europe-southwest1"  # zones defined in pools_map are from this region
