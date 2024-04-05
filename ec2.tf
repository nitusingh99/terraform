# Public Instance
resource "aws_instance" "public_instance" {
  ami             = "ami-0c84181f02b974bc3"  # Specify the appropriate AMI ID
  instance_type   = "t2.micro"  # Specify the desired instance type
  subnet_id       = aws_subnet.public_subnet_1.id  # Use the public subnet
  security_groups = [aws_security_group.public_sg.id]  # Attach the public security group
  key_name        = "public"  # Specify your key pair name
  
  tags = {
    Name = "public_instance"
  }
}

# Private Instance
resource "aws_instance" "private_instance" {
  ami             = "ami-0c84181f02b974bc3"  # Specify the appropriate AMI ID
  instance_type   = "t2.micro"  # Specify the desired instance type
  subnet_id       = aws_subnet.private_subnet_1.id  # Use the private subnet
  security_groups = [aws_security_group.private_sg.id]  # Attach the private security group
  key_name        = "private"  # Specify your key pair name

 user_data = <<-EOF
             #!/bin/bash
             sudo yum update -y 
             sudo yum install httpd -y
             sudo systemctl start httpd
             sudo systemctl enable httpd 
             cd /var/www/html
             html_content=' <img src="https://www.google.com/url?sa=i&url=https%3A%2F%2Falphacoders.com%2Fnezuko-kamado-wallpapers&psig=AOvVaw3pI2s_RiXlmeI9HTrjyLB3&ust=1705763603204000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCMCuxuze6YMDFQAAAAAdAAAAABAD">NEZUKO-CHAN</img>'
             echo "$html_content" >> index.html
             EOF

  tags = {
    Name = "private_instance"
  }
}

# Database Instance
resource "aws_instance" "db_instance" {
  ami             = "ami-0c84181f02b974bc3"  # Specify the appropriate AMI ID
  instance_type   = "t2.micro"  # Specify the desired instance type
  subnet_id       = aws_subnet.DB_subnet_1.id  # Use the database subnet
  security_groups = [aws_security_group.rds_sg.id]  # Attach the RDS security group
  key_name        = "private"  # Specify your key pair name
  tags = {
    Name = "db_instance"
  }
}
