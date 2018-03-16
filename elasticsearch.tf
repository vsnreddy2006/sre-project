resource "aws_security_group" "allow_elasticsearch" {
  name = "allow_elasticsearch"
  description = "All all elasticsearch traffic"
  vpc_id = "vpc-a03059d9"
  #vpc_id = "${var.aws_vpc.main.id}"

  # elasticsearch port
  ingress {
    from_port   = 9200
    to_port     = 9200
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

resource "aws_instance" "elasticsearch" {
  ami           = "ami-223f945a"
  instance_type = "t2.medium"
  key_name      = "${var.key}"
  subnet_id     = "subnet-3728f44e"
  vpc_security_group_ids = [
    "${aws_security_group.allow_elk.id}",
  ]

  provisioner "file" {
    source        = "${path.module}/conf/elasticsearch.yml"
    destination   = "/tmp/elasticsearch.yml"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${var.private_key}"
    }
  }


  provisioner "remote-exec" {
    script        = "${path.module}/scripts/rhel/elasticsearch.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${var.private_key}"
    }
  }

  depends_on = ["aws_security_group.allow_elasticsearch"]
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.elasticsearch.id}"
}