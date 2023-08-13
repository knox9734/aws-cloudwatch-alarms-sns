# Define the AWS provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create an SNS topic for alarm notifications
resource "aws_sns_topic" "cloud_watch_notify" {
  name = "testalarmemail"  # Replace with your SNS topic name
}

# Create an SNS subscription to receive alarm notifications via email
resource "aws_sns_topic_subscription" "cloud_watch_notify_subscription" {
  topic_arn = aws_sns_topic.cloud_watch_notify.arn
  protocol  = "email"
  endpoint  = "kavindubandaranayakemah0@gmail.com"  # Replace with your email address
}

# Create a test RDS instance for monitoring
resource "aws_db_instance" "rds_instance" {
  identifier             = "test-rds-instance"  # Replace with your desired test instance identifier
  engine                 = "mysql"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  #name                   = "testdb"
  username               = "admin"
  password               = "MyPassword12"
}

# Create a CloudWatch alarm for monitoring RDS database connections
resource "aws_cloudwatch_metric_alarm" "RDS_Connections_Alarm" {
  alarm_name          = "RDS Connections Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = 10  # Replace with your desired threshold for database connections
  alarm_description   = "RDS database connections exceed the threshold of 10"  # Replace with your desired alarm description
  alarm_actions       = [aws_sns_topic.cloud_watch_notify.arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.rds_instance.identifier
  }
}

# Create a CloudWatch alarm for monitoring RDS CPU utilization
resource "aws_cloudwatch_metric_alarm" "RDS_CPU_Utilization_Alarm" {
  alarm_name          = "RDS CPU Utilization Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = 90  # Replace with your desired threshold for CPU utilization
  alarm_description   = "RDS CPU utilization exceeds the threshold of 90%"  # Replace with your desired alarm description
  alarm_actions       = [aws_sns_topic.cloud_watch_notify.arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.rds_instance.identifier
  }
}
