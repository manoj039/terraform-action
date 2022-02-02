variable "project_id" {
  description = "The project ID to host the cluster in"
  type        = string
}

variable "network_project_id" {
  description = "The GCP project housing the VPC network to host the cluster in"
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  type        = string
}

variable "cluster_name" {
  description = "Name of the GKE Cluster"
  type        = string

}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

variable "zones" {
  type        = list(string)
  description = "The zone to host the cluster in (required if is a zonal cluster)"
}

variable "network" {
  description = "The VPC network to host the cluster in"
  type        = string

}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
  type        = string

}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
  type        = string

}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
  type        = string

}

variable "cluster_autoscaling" {
  type = object({
    enabled             = bool
    autoscaling_profile = string
    min_cpu_cores       = number
    max_cpu_cores       = number
    min_memory_gb       = number
    max_memory_gb       = number
    gpu_resources = list(object({
      resource_type = string
      minimum       = number
      maximum       = number
    }))
  })
  default = {
    enabled             = true
    autoscaling_profile = "BALANCED"
    max_cpu_cores       = 0
    min_cpu_cores       = 0
    max_memory_gb       = 0
    min_memory_gb       = 0
    gpu_resources       = []
  }
  description = "Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling)"
}


variable "master_ip" {
  description = "(Beta) The IP range in CIDR notation to use for the hosted master network"
  type        = string

}

variable "subnet_cidr" {
  description = "Subnet CIDR range for master_authorized_networks"
}

variable "gke_service_account" {
  description = "The service account to run nodes as if not overridden in node_pools. The create_service_account variable default value (true) will cause a cluster-specific service account to be created."
  type        = string
}

variable "env" {
  description = "Environment for the resource to be deployed in"
}

variable "devops_project_id" {
  description = "DevOps project ID"
}
