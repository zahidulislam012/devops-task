module "web-application-asg" {
  source = "../tf-modules/autoscale"
  name   = "${local.env}-${local.project}-web-application"

  vpc_zone_identifier = [data.aws_subnet.private-subnet-1a.id, data.aws_subnet.private-subnet-1b.id, data.aws_subnet.private-subnet-1c.id]
  min_size            = local.web-application-min-instance-count
  desired_capacity    = local.web-application-desired-instance-count
  max_size            = local.web-application-max-instance-count

  target_group_enabled   = true
  autoscaling_group_name = module.web-application-asg.asg_name
  alb_target_group_arn   = module.web-application-tg.tg_arn
  launch_template        = module.web-application-lt.lt-id

  asg_mixed_instance_types                 = local.asg-mixed-instance-types
  spot_allocation_strategy                 = local.spot-allocation-strategy
  spot_instance_pools                      = local.spot-instance-pools
  on_demand_percentage_above_base_capacity = local.on-demand-percentage-above-base-capacity

  tags = [
    {
      key                 = "Environment"
      value               = local.env
      propagate_at_launch = false
    },
    {
      key                 = "Version"
      value               = local.version
      propagate_at_launch = false
    },
    {
      key                 = "Owner"
      value               = local.owner
      propagate_at_launch = false
    },
    {
      key                 = "Cost-Center"
      value               = local.cost-center
      propagate_at_launch = false
    },
    {
      key                 = "Project"
      value               = local.project
      propagate_at_launch = false
    }
  ]
}