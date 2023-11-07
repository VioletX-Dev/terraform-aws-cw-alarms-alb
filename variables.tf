variable "alarm_notification_channel" {
  description = "It's a SNS that might send emails, page your Incident Response tool (Pager Duty, OpsGenie, VitorOps, etc)"
  type        = string
}

variable "alb_names" {
  description = "ALB names to create the alarms. `e.g. sqs_names = [\"alb_1\", \"alb_2\", \"alb_3\"]`"
  type        = set(string)
}
