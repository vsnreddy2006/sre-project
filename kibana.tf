resource "aws_security_group" "allow_kibana" {
  name = "allow_kibana"
  description = "All all kibana traffic"
  vpc_id = "vpc-a03059d9"
  #vpc_id = "${var.aws_vpc.main.id}"

 # kibana ports
  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_elb" "kiban-lb" {
  name 	          = "kibana-loadbalancer"

  subnets         = ["subnet-3728f44e","subnet-3925a44g"]
  security_groups = ["aws_security_group.allow_kibana.id"]
  instances       = ["${aws_instance.kibana.id}"]

  listener {
    instance_port     = 5601
    instance_protocol = "http"
    lb_port           = 443
    lb_protocol       = "https"
  }
}

resource "aws_instance" "kibana" {
  ami           = "ami-223f945a"
  instance_type = "t2.micro"
  key_name      = "${var.key}"
  subnet_id     = "subnet-3728f44e"
  vpc_security_group_ids = [
    "${aws_security_group.allow_elk.id}",
  ]

  provisioner "file" {
    source        = "${path.module}/conf/kibana.yml"
    destination   = "/tmp/kibana.yml"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${var.private_key}"
    }
  }


  provisioner "remote-exec" {
    script        = "${path.module}/scripts/rhel/kibana.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${var.private_key}"
    }
  }

  depends_on = ["aws_security_group.allow_kibana"]
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.kibana.id}"
}