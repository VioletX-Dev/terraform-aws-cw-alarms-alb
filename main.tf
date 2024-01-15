resource "aws_cloudwatch_metric_alarm" "alb_5xx_errors" {
  for_each = var.alb_names

  ## metric
  namespace   = "AWS/ApplicationELB"
  metric_name = "HTTPCode_ELB_5XX_Count"
  dimensions = {
    LoadBalancer = each.value
  }
  period = 300

  ## condictions
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Sum"
  threshold           = 10
  evaluation_periods  = 2

  ## alarm 
  alarm_name        = "${each.value}-lb-5XX-errors"
  alarm_description = "5XX Errors in ${each.value} are higher than 10 in 5 minutes. Normal is close to Zero."
  actions_enabled   = "true"
  alarm_actions     = [var.alarm_notification_channel]
  ok_actions        = [var.alarm_notification_channel]

  tags = {
    developed = "VioletX.com"
    terraform = "true"
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_latency_errors" {
  for_each = var.alb_names

  ## metric
  namespace   = "AWS/ApplicationELB"
  metric_name = "TargetResponseTime"
  dimensions = {
    LoadBalancer = each.value
  }
  period = 300

  ## condictions
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Sum"
  threshold           = 1000
  evaluation_periods  = 2

  ## alarm 
  alarm_name        = "${each.value}-lb-latency"
  alarm_description = "Latency in ${each.value} is higher than 1 second in 5 minutes. Normal is close to 10ms."
  actions_enabled   = "true"
  alarm_actions     = [var.alarm_notification_channel]
  ok_actions        = [var.alarm_notification_channel]

  tags = {
    developed = "VioletX.com"
    terraform = "true"
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_healthy_host_errors" {
  for_each = var.alb_names

  ## metric
  namespace   = "AWS/ApplicationELB"
  metric_name = "UnHealthyHostCount"
  dimensions = {
    LoadBalancer = each.value
  }
  period = 300

  ## condictions
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Sum"
  threshold           = 2
  evaluation_periods  = 2

  ## alarm 
  alarm_name        = "${each.value}-lb-latency"
  alarm_description = "Hosts of ${each.value} are unhealthy in 5 minutes. Normal is 0 unhealthy hosts."
  actions_enabled   = "true"
  alarm_actions     = [var.alarm_notification_channel]
  ok_actions        = [var.alarm_notification_channel]

  tags = {
    developed = "VioletX.com"
    terraform = "true"
  }
}
