
# pi-quodd-socket
// LOAD BALANCER
//arn:aws:acm:us-east-1:533620758524:certificate/b8bff003-feaf-469c-b3db-7eca8c2d9f29

resource "aws_lb" "tribes_lb" {
  name     = "tribes-load-balancer"
  internal = false

  # security_groups = ["sg-07f4a446b97db9116", "sg-031f44989a0737c58"]
  subnets = data.aws_subnet_ids.tribes.ids

  # idle_timeout               = 60
  # enable_deletion_protection = false

  # access_logs {
  #   bucket  = "ioi18-logs"
  #   prefix  = "elb"
  #   enabled = true
  # }
}

resource "aws_lb_listener" "tribes_80" {
  load_balancer_arn = aws_lb.tribes_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tribes.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "tribes_443" {
  load_balancer_arn = aws_lb.tribes_lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = "arn:aws:acm:us-east-1:533620758524:certificate/b8bff003-feaf-469c-b3db-7eca8c2d9f29"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

  default_action {
    target_group_arn = aws_lb_target_group.tribes.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "tribes" {
  name     = "tribes"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  # target_type = "instance"

  # deregistration_delay = 60
  # slow_start           = 0

  # health_check {
  #   path                = "/httpd_alived"
  #   interval            = 6
  #   healthy_threshold   = 3
  #   unhealthy_threshold = 2
  #   matcher             = "200"
  # }
}

//

resource "aws_elastic_beanstalk_application" "fetch" {
  name        = format("%s-%s", local.org, local.name)
  description = ""
  tags        = local.common_tags
}

resource "aws_elastic_beanstalk_environment" "fetch" {
  count = length(local.env)

  name                = format("%s-%s-%s", local.env[count.index], local.org, local.name)
  cname_prefix        = format("%s-%s-%s", local.env[count.index], local.org, local.name)
  application         = aws_elastic_beanstalk_application.fetch.name
  tier                = "WebServer"
  solution_stack_name = "64bit Amazon Linux 2 v3.2.5 running Docker"

  # vpc
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "public"
  }
  # setting {
  #   namespace = "aws:ec2:vpc"
  #   name      = "VPCId"
  #   value     = "vpc-xxxxxxxx"
  # }
  # setting {
  #   namespace = "aws:ec2:vpc"
  #   name      = "Subnets"
  #   value     = "subnet-xxxxxxxx"
  # }
  # setting {
  #   namespace = "aws:ec2:vpc"
  #   name      = "AssociatePublicIpAddress"
  #   value     = true
  # }

  # ec2
  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = "t3.small,t2.small"
  }
  # setting {
  #   namespace = "aws:ec2:instances"
  #   name      = "EnableSpot"
  #   value     = false
  # }
  # setting {
  #   namespace = "aws:ec2:instances"
  #   name      = "SpotMaxPrice"
  #   value     = false
  # }

  # autoscaling
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "zion"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    # value     = "default,awseb-e-mgcy9ixhpy-stack-AWSEBSecurityGroup-DARM0H0KODMZ"
    value = "default"
  }

  # health
  # setting {
  #   namespace = "aws:elasticbeanstalk:application"
  #   name      = "Application Healthcheck URL"
  #   value     = "/"
  # }

  # loadbalancer
  # setting {
  #   namespace = "aws:elasticbeanstalk:environment"
  #   name      = "EnvironmentType"
  #   value     = "LoadBalanced"
  # }
  # setting {
  #   namespace = "aws:elasticbeanstalk:environment"
  #   name      = "LoadBalancerType"
  #   value     = "application"
  # }
  # setting {
  #   namespace = "aws:elasticbeanstalk:environment"
  #   name      = "LoadBalancerIsShared"
  #   value     = false
  # }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerIsShared"
    value     = true
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SharedLoadBalancer"
    value     = aws_lb.tribes_lb.arn
  }

  # Add environment variables if provided
  dynamic "setting" {
    for_each = var.env_vars[local.env[count.index]]
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = setting.key
      value     = setting.value
      resource  = ""
    }
  }

  tags = merge(
    { env = local.env[count.index] },
    local.common_tags
  )
}

resource "aws_lb_target_group_attachment" "tribes" {
  target_group_arn = aws_lb_target_group.tribes.arn
  target_id        = aws_elastic_beanstalk_environment.fetch[0].instances[0]
  port             = 80
}

variable "env_vars" {
  type        = map(map(string))
  default     = {}
  description = "Map of custom ENV variables to be provided to Elstic Beanstalk"
}
