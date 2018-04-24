/* Default security group */
resource "aws_security_group" "default" {
  name = "default-secgrp"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  tags { 
    Name = "default-secgrp" 
  }
}

/* Security group for the nat server */
resource "aws_security_group" "nat" {
  name = "nat-secgrp"
  description = "Security group for nat instances that allows SSH traffic from internet. Also allows outbound HTTP[S]"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags { 
    Name = "nat-secgrp" 
  }
}

/* Security group for the web */
resource "aws_security_group" "web" {
  name = "web-secgrp"
  description = "Security group for web that allows web traffic from internet"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5000
    to_port   = 5000
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port = 500
    to_port   = 500
    protocol  = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port = 4500
    to_port   = 4500
    protocol  = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }
  ingress{
    from_port = "10250"
    to_port = "10250"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = "31499"
    to_port = "31499"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
	egress {
  	from_port = 0
  	to_port = 0
  	protocol = "-1"
  	cidr_blocks = ["0.0.0.0/0"]
	}
  tags { 
    Name = "web-secgrp" 
  }
}