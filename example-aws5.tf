resource "aws_instance" "terraform_demo" {
        ami = "ami-096fda3c22c1c990a"
        instance_type = "t3.micro"
        count = 3
        key_name = "mykey2pem"
        tags = {
                class = "terraform_demo" 
                Name = "Tuts test"
        }
}

output "instance_id" {
   value = aws_instance.terraform_demo.*.public_ip
}
locals {
        ingress_rules = [{
                port        = 443
                description = "Port 443"
        },
        {
                port        = 22
                description = "Port 22"
        }]
dynamic "ingress" {
        for_each = local.ingress_rules

        content {
                        description = ingress.value.description
                        from_port   = ingress.value.port
                        to_port     = ingress.value.port
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                }
}

  connection {
                type        = "ssh"
                host        = aws_instance.terraform_demo.*.public_ip
                user        = "ubuntu"
                private_key = file("/home/labsuser/terra4/myKey.pem")
                # Default timeout is 5 minutes
                timeout     = "4m"
  }   

  provisioner "remote-exec" {
                inline = [
                        "touch /home/ubuntu/tuts-remote-exec.txt"
                ]
  }

}
