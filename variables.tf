variable "hcloud_token" {
  description = "The API token for Hetzner Cloud"
  type        = string
}


variable "ssh_key_name" {
  description = "The SSH key name to use for the server"
  type        = string
}

variable "ssh_pub_key_path" {
  description = "Path to the public SSH key file"
  type        = string
}

variable "ssh_priv_key_path" {
  description = "Path to the private SSH key file"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "default"
}

variable "hcloud_image_name" {
  description = "Name of the Hetzner Cloud image"
  type        = string
  default     = "ubuntu-24.04"
}

variable "hcloud_location_name" {
  description = "Name of the Hetzner Cloud location"
  type        = string
  default     = "nbg1"
}

variable "hcloud_server_type_name" {
  description = "Type of the Hetzner Cloud server"
  type        = string
  default     = "cx11"
}

variable "network_ip_range" {
  description = "The IP range for the network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_ip_range" {
  description = "The IP range for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "server_network_ip" {
  description = "IP address for the server in the network"
  default     = "10.0.1.2"
}
