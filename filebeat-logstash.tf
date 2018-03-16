resource "aws_security_group" "allow_logstash" {
  name = "allow_logstash"
  description = "All all logstash traffic"
  vpc_id = "vpc-a03059d9"

  # logstash port
  ingress {
    from_port   = 5043
    to_port     = 5044
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

resource "aws_instance" "filebeat-logstash" {
  ami           = "ami-223f945a"
  instance_type = "t2.micro"
  key_name      = "${var.key}"
  subnet_id     = "subnet-3728f44e"
  vpc_security_group_ids = [
    "${aws_security_group.allow_logstash.id}",
  ]

  provisioner "file" {
    source        = "${path.module}/conf/logstash.yml"
    destination   = "/tmp/logstash.yml"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${var.private_key}"
    }
  }

  provisioner "file" {
    source        = "${path.module}/conf/filebeat.yml"
    destination   = "/tmp/filebeat.yml"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${var.private_key}"
    }
  }

  provisioner "file" {
    source        = "${path.module}/conf/beats.conf"
    destination   = "/tmp/beats.conf"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${var.private_key}"
    }
  }

  provisioner "remote-exec" {
    script        = "${path.module}/scripts/rhel/filebeat-logstash"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${var.private_key}"
    }
  }

  depends_on = ["aws_security_group.allow_logstash"]
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.filebeat-logstash.id}"
}


