project_id = "ace-ripsaw-311918"
region     = "europe-west2"

/******************************************
   Env Networking Variables
 *****************************************/

env_host_vpc_name = "network-1"
env_host_vpc_subnets = [
  {
    subnet_name           = "subnet-1"
    subnet_ip             = "10.237.6.0/26"
    subnet_region         = "us-east1"
    subnet_private_access = "true"
    subnet_flow_logs      = "true"
    description           = "This subnet has a description"
  }
]

env_host_vpc_subnets_secondary_ranges = {
  subnet-1 = [
    {
      range_name    = "pod-subnet"
      ip_cidr_range = "11.0.0.0/24"
    },
    {
      range_name    = "service-subnet"
      ip_cidr_range = "11.0.1.0/24"
    }
  ]
}

/******************************************
   GKE Cluster Variables
 *****************************************/

cluster_name_suffix = ""
cluster_name        = "gke-cluster-1"
zones               = ["europe-west2-a", "europe-west2-b"]
master_ip           = "0.0.0.0/0"
