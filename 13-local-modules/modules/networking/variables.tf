variable "vpc_config" {
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block in vpc_config must be a valid CIDR block."
  }
}

variable "subnet_configs" {
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)
  }))

  validation {
    condition     = alltrue([for subnet in var.subnet_configs : can(cidrnetmask(subnet.cidr_block))])
    error_message = "All cidr_blocks in subnet_configs must be valid CIDR blocks."
  }
}