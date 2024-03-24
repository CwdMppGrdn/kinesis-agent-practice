#!/bin/bash
sudo dnf update -y

# awscliのインストール
sudo dnf install -y python3
sudo dnf install -y python3-pip
sudo pip3 install awscli

# cloudwatch-agent、ssm-agent、jqのインストール
dnf install -y amazon-cloudwatch-agent amazon-ssm-agent jq
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# ec2-instance-connectのインストール
mkdir /tmp/ec2-instance-connect
curl https://amazon-ec2-instance-connect-us-west-2.s3.us-west-2.amazonaws.com/latest/linux_amd64/ec2-instance-connect.rpm -o /tmp/ec2-instance-connect/ec2-instance-connect.rpm
curl https://amazon-ec2-instance-connect-us-west-2.s3.us-west-2.amazonaws.com/latest/linux_amd64/ec2-instance-connect-selinux.noarch.rpm -o /tmp/ec2-instance-connect/ec2-instance-connect-selinux.rpm
sudo dnf install -y /tmp/ec2-instance-connect/ec2-instance-connect.rpm /tmp/ec2-instance-connect/ec2-instance-connect-selinux.rpm

# kinesis-agentのインストール
sudo dnf install -y https://s3.amazonaws.com/streaming-data-agent/aws-kinesis-agent-latest.amzn2.noarch.rpm
sudo usermod -G wheel aws-kinesis-agent-user
sudo mv /etc/aws-kinesis/agent.json /etc/aws-kinesis/agent_bk.json
aws ssm get-parameter --region ap-northeast-1 --name "/kinesis-agent/config"|jq -r .Parameter.Value|sudo tee /etc/aws-kinesis/agent.json
sudo chmod 644 /etc/aws-kinesis/agent.json
sudo service aws-kinesis-agent start
sudo chkconfig aws-kinesis-agent on