resource "aws_ssm_parameter" "example" {
  name  = var.ssm_parameter_name
  type  = "String"
  value = jsonencode({
    flows = [
      {
        filePattern: "/var/log/messages*",
        kinesisStream: "${aws_kinesis_firehose_delivery_stream.example.name}"
      }
    ]
  })
}