variable "name" {}

variable "asg_mixed_instance_types" {}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "vpc_zone_identifier" {
  type = list(string)
}

variable "launch_template" {}

variable "policy_enabled" {
  default = false
  type = bool
}

variable "scale-up-policy" {
  default = false
  type = bool
}

variable "scale-down-policy" {
  default = false
  type = bool
}

variable "on_demand_percentage_above_base_capacity" {
  default = 50
  type = number
}

variable "spot_allocation_strategy" {
  default = "capacity-optimized"
}

variable "tags_as_map" {
  description = "A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws_autoscaling_group requires."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  type        = list(map(string))
  default     = []
}

variable "target_group_enabled" {
  type = bool
}

variable "autoscaling_group_name" {
  default = null
}

variable "alb_target_group_arn" {
  default = null
}
variable "spot_instance_pools" {
  default = 0
}