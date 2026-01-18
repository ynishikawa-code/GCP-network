variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  default     = "asia-northeast1"
}

variable "zone" {
  description = "GCP zone"
  default     = "asia-northeast1-a"
}

variable "instance_name" {
  description = "Name of the compute instance"
  default     = "rocky-web"
}
