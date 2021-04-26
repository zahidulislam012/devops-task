resource "aws_autoscaling_group" "asg" {
  name = var.name
  max_size = var.max_size
  min_size = var.min_size
  desired_capacity = var.desired_capacity
  default_cooldown = "180"
  health_check_grace_period = "120"
  health_check_type = "ELB"
  force_delete = true
  termination_policies = ["OldestInstance", "OldestLaunchTemplate"]
  vpc_zone_identifier = var.vpc_zone_identifier
  enabled_metrics = [ "GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = var.launch_template
        version = "$Latest"
      }
      dynamic "override" {
        for_each = var.asg_mixed_instance_types
        content {
          instance_type = override.key
          weighted_capacity = override.value
        }
      }
    }
    instances_distribution {
      on_demand_base_capacity = "0"
      on_demand_allocation_strategy = "prioritized"
      on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
      spot_instance_pools = var.spot_instance_pools
      spot_allocation_strategy = var.spot_allocation_strategy
    }
  }
  tags = concat(
  [
    {
      key = "Name"
      value = var.name
      propagate_at_launch = false
    },
  ],
  var.tags,
  local.tags_asg_format,
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes = [target_group_arns]
  }
}
locals {
  tags_asg_format = null_resource.tags_as_list_of_maps.*.triggers
}

resource "null_resource" "tags_as_list_of_maps" {
  count = length(keys(var.tags_as_map))

  triggers = {
    "key"                 = keys(var.tags_as_map)[count.index]
    "value"               = values(var.tags_as_map)[count.index]
    "propagate_at_launch" = "true"
  }
}

resource "aws_autoscaling_attachment" "asg-attachment" {
  count = var.target_group_enabled ? 1 : 0
  autoscaling_group_name = var.autoscaling_group_name
  alb_target_group_arn   = var.alb_target_group_arn
}
