#AWS CloudWatch Alarms and SNS Notifications Setup#
###################################################
This Terraform configuration provides a simple way to create AWS CloudWatch alarms and SNS notifications for monitoring Amazon RDS instances. CloudWatch alarms help you monitor your resources and take automated actions based on the defined criteria. SNS (Simple Notification Service) is used to send notifications about alarm states to specified endpoints, such as email addresses.

Prerequisites
Before you begin, make sure you have the following prerequisites:

An AWS account with appropriate permissions to create resources.
Terraform installed on your local machine.

Configuration Overview
The provided Terraform script (main.tf) sets up the following resources:

AWS Provider Configuration: Configures the AWS provider with the desired region (us-east-1 in this case).

SNS Topic: Creates an SNS topic named cloud_watch_notify for receiving alarm notifications.

SNS Subscription: Creates an SNS subscription that sends alarm notifications to the specified email address.

RDS Instance: Creates a test Amazon RDS instance for monitoring. You can customize the instance parameters as needed.

CloudWatch Alarms:
Creates a CloudWatch alarm named RDS_Connections_Alarm to monitor RDS database connections. It triggers when the number of connections exceeds the specified threshold.
Creates a CloudWatch alarm named RDS_CPU_Utilization_Alarm to monitor RDS CPU utilization. It triggers when CPU utilization exceeds the specified threshold.

Usage
Clone this repository to your local machine.

Navigate to the cloned repository directory:


cd aws-cloudwatch-alarms-sns

Create a terraform.tfvars file to provide values for sensitive variables:

aws_access_key = "YOUR_AWS_ACCESS_KEY"
aws_secret_key = "YOUR_AWS_SECRET_KEY"

Initialize the Terraform configuration:

terraform init

Review the configuration in main.tf and adjust the resource parameters as needed.

Apply the configuration to create resources:

terraform apply

Confirm the action with a yes when prompted.

Once the configuration is applied successfully, CloudWatch alarms and SNS notifications will be set up according to the specified parameters.

Cleanup
To clean up and delete the created resources:

Run the following command:

terraform destroy

Confirm the action with a yes when prompted.

All created resources, including CloudWatch alarms and the SNS topic, will be deleted.

Note
Ensure that you replace placeholder values such as email addresses, instance identifiers, thresholds, and descriptions with your actual values.
Be cautious when using this configuration in a production environment. This example provides a basic setup for educational purposes and may need further customization and consideration for real-world scenarios.
