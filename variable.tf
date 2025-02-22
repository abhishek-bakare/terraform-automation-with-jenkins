variable "cidr" {

  description = "CIDR for VPC"
  type        = string
  default     = "192.168.0.0/16"

}

variable "enable_dns_hostnames" {

  description = "Enabling dns hostnames"
  type        = string
  default     = null

}

variable "enable_dns_support" {

  description = "Enabling dns hostnames"
  type        = string
  default     = null

}

variable "vpc_name" {

  description = "CIDR for VPC"
  type        = string
  default     = "vi_vpc"

}

variable "my_igw_name" {

  description = "Creating IGW"
  type        = string
  default     = "vi_igw"

}

variable "pub_sub_cidr_1" {

  description = "CIDR for pub subnet 1"
  type        = string
  default     = "192.168.1.0/24"

}

variable "map_public_ip_on_launch" {

  description = "Enambling public IP for pub subnets"
  type        = bool
  default     = null

}

variable "pub_subnet_name_1" {

  description = "Name for pub sub 1"
  type        = string
  default     = "vi_public_subnet_1"

}

variable "pub_sub_cidr_2" {

  description = "CIDR for pub subnet 2"
  type        = string
  default     = "192.168.2.0/24"

}


variable "pub_subnet_name_2" {

  description = "Name for pub sub 2"
  type        = string
  default     = "vi_public_subnet_2"

}

variable "pvt_sub_cidr_1" {

  description = "Name for pvt sub 1"
  type        = string
  default     = "192.168.5.0/24"

}

variable "pvt_subnet_name_1" {

  description = "Name for pub sub 1"
  type        = string
  default     = "vi_private_subnet_1"

}

variable "pvt_sub_cidr_2" {

  description = "Name for pvt sub 2"
  type        = string
  default     = "192.168.6.0/24"

}

variable "pvt_subnet_name_2" {

  description = "Name for pub sub 2"
  type        = string
  default     = "vi_private_subnet_2"

}

variable "public_route_table_name" {

  description = "Name for public route table"
  type        = string
  default     = "vi_public_route_table"

}

variable "database_route_table_name" {

  description = "Name for private route table"
  type        = string
  default     = "vi_private_route_table"

}

