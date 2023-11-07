resource "aws_cloudwatch_metric_alarm" "sqs_messages_age" {
  for_each = var.alb_names

  ## metric
  namespace   = "AWS/ApplicationELB"
  metric_name = "HTTPCode_ELB_5XX_Count"
  dimensions = {
    QueueName = each.value
  }
  period = 300

  ## condictions
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Sum"
  threshold           = 10
  evaluation_periods  = 2

  ## alarm 
  alarm_name        = "${each.value}-5XX-errors"
  alarm_description = "5XX Errors in ${each.value} are higher than 10 in 5 minutes. Normal is close to Zero."
  actions_enabled   = "true"
  alarm_actions     = [var.alarm_notification_channel]
  ok_actions        = [var.alarm_notification_channel]

  tags = {
    developed = "VioletX.com"
    terraform = "true"
  }
}
