#!/bin/bash
yum update -y
yum install -y httpd
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head><title>Load Balancer Test</title></head>
<body style="font-family: Arial; text-align: center; padding: 50px;">
    <h1 style="color: #ff9900;">🚀 Auto Scaling Demo</h1>
    <p><strong>Instance ID:</strong> $INSTANCE_ID</p>
    <p><strong>Availability Zone:</strong> $AZ</p>
    <p><strong>Current Time:</strong> $(date)</p>
    <hr>
    <p>✅ This instance is part of an Auto Scaling Group!</p>
</body>
</html>
EOF
systemctl start httpd
systemctl enable httpd
