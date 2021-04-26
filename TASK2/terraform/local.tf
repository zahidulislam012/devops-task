locals {
  env         = terraform.workspace
  owner       = ""
  cost-center = ""
  project     = ""
  version     = ""
  common_tags = {
    Environment = local.env
    Version     = local.version
    Owner       = local.owner
    Cost-Center = local.cost-center
    Project     = local.project
  }

  internal_vpc_ids = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  internal-vpc = local.internal_vpc_ids[local.env]
  public_subnet_block_1a = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  public-subnet-block-1a = local.public_subnet_block_1a[local.env]
  public_subnet_block_1b = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  public-subnet-block-1b = local.public_subnet_block_1b[local.env]
  public_subnet_block_1c = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  public-subnet-block-1c = local.public_subnet_block_1c[local.env]
  private_subnet_block_1a = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  private-subnet-block-1a = local.private_subnet_block_1a[local.env]
  private_subnet_block_1b = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  private-subnet-block-1b = local.private_subnet_block_1b[local.env]
  private_subnet_block_1c = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  private-subnet-block-1c = local.private_subnet_block_1c[local.env]

  tf_desired_capacity = {
    uat  = local.min-size
    sb   = local.min-size
    lt   = local.min-size
    prod = local.min-size
  }
  web-application-desired-instance-count = local.tf_desired_capacity[local.env]
  tf_min_size = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  web-application-min-instance-count = local.tf_min_size[local.env]
  tf_max_size = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  web-application-max-instance-count = local.tf_max_size[local.env]
  tf_asg_mixed_instance_types = {
    uat = [
      { name = "t4g.medium", weight = "1" },
      { name = "t3.medium", weight = "1" },
      { name = "t3a.medium", weight = "1" }
    ]
    sb = [
      { name = "m5.xlarge", weight = "1" },
      { name = "m5d.xlarge", weight = "1" },
      { name = "m5a.xlarge", weight = "1" },
      { name = "m5ad.xlarge", weight = "1" },
      { name = "m5n.xlarge", weight = "1" },
      { name = "m5dn.xlarge", weight = "1" },
      { name = "m4.xlarge", weight = "1" }
    ]
    lt = [
      { name = "m5.xlarge", weight = "1" },
      { name = "m5d.xlarge", weight = "1" },
      { name = "m5a.xlarge", weight = "1" },
      { name = "m5ad.xlarge", weight = "1" },
      { name = "m5n.xlarge", weight = "1" },
      { name = "m5dn.xlarge", weight = "1" },
      { name = "m4.xlarge", weight = "1" }
    ]
    prod = [
      { name = "m5.xlarge", weight = "1" },
      { name = "m5d.xlarge", weight = "1" },
      { name = "m5a.xlarge", weight = "1" },
      { name = "m5ad.xlarge", weight = "1" },
      { name = "m5n.xlarge", weight = "1" },
      { name = "m5dn.xlarge", weight = "1" },
      { name = "m4.xlarge", weight = "1" }
    ]
  }
  asg-mixed-instance-types = local.tf_asg_mixed_instance_types[local.env]
  tf_spot_allocation_strategy = {
    uat  = "lowest-price"
    sb   = "lowest-price"
    lt   = "lowest-price"
    prod = "capacity-optimized"
  }
  spot-allocation-strategy = local.tf_spot_allocation_strategy[local.env]
  tf_spot_instance_pools = {
    uat  = "1"
    sb   = "1"
    lt   = "1"
    prod = "0"
  }
  spot-instance-pools = local.tf_spot_instance_pools[local.env]
  tf_on_demand_percentage_above_base_capacity = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  on-demand-percentage-above-base-capacity = local.tf_on_demand_percentage_above_base_capacity[local.env]
  tf_instance_type = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  instance-type = local.tf_instance_type[local.env]
  tf_worker-keypair = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  web-application-keypair = local.tf_worker-keypair[local.env]
  rds-engine-version = local.tf_engine_version[local.env]
  tf_rds_master_password = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  rds-master-password = local.tf_rds_master_password[local.env]
  tf_rds_master_username = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  rds-master-username = local.tf_rds_master_username[local.env]
  tf_rds_instances_type = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  rds-instances-type = local.tf_rds_instances_type[local.env]
  tf_rds_family = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  rds-family = local.tf_rds_family[local.env]
  tf_domain-name = {
    uat  = ""
    sb   = ""
    lt   = ""
    prod = ""
  }
  domain-name = local.tf_domain-name[local.env]
}

// Microservice Locals

