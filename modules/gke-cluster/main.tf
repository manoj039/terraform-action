# Module for kubernetes cluster
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source             = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  project_id         = var.project_id
  network_project_id = var.network_project_id
  name               = var.cluster_name
  region             = var.region
  regional           = true
  # zones                             = var.zones
  network                           = var.network
  subnetwork                        = var.subnetwork
  ip_range_pods                     = var.ip_range_pods
  ip_range_services                 = var.ip_range_services
  create_service_account            = false
  remove_default_node_pool          = true
  cluster_autoscaling               = var.cluster_autoscaling
  horizontal_pod_autoscaling        = true
  http_load_balancing               = true
  network_policy                    = true
  enable_private_endpoint           = true
  enable_private_nodes              = true
  enable_intranode_visibility       = true
  enable_pod_security_policy        = true
  master_ipv4_cidr_block            = var.master_ip
  enable_shielded_nodes             = true
  release_channel                   = "STABLE"
  enable_binary_authorization       = true
  disable_legacy_metadata_endpoints = true
  master_global_access_enabled      = false
  default_max_pods_per_node         = 30
  master_authorized_networks = [
    {
      cidr_block   = var.subnet_cidr
      display_name = "VPC"
    },
  ]

  node_pools = [
    {
      name           = "default-pool"
      machine_type   = "n1-standard-16"
      node_locations = "${var.region}-b,${var.region}-c"
      autoscaling    = true
      #node_count         = 2
      min_count                   = 1
      max_count                   = 3
      initial_node_count          = 1
      disk_type                   = "pd-ssd"
      disk_size_gb                = 256
      image_type                  = "COS"
      local_ssd_count             = "0"
      auto_repair                 = true
      auto_upgrade                = true
      service_account             = var.gke_service_account
      sandbox_enabled             = false
      cpu_manager_policy          = "static"
      cpu_cfs_quota               = true
      preemptible                 = false
      enable_integrity_monitoring = true
      enable_secure_boot          = true
      tags                        = "direct-iap,hawkeye-${var.env}"
      node_metadata               = "GKE_METADATA_SERVER"
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-pool = {
      default-pool = true,
      env          = var.env
      location     = var.region
    }
  }

  node_pools_tags = {
    all = []

    default-pool = [
      "default-pool",
    ]
  }


  cluster_resource_labels = {
    env      = var.env,
    location = var.region,
  }
}
