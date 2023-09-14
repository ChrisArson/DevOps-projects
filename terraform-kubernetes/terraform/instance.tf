resource "aws_key_pair" "k8s-key" {
	key_name = "terra-k8s-key"
	public_key = file("data/id_rsa.pub")	
}

resource "aws_instance" "name" {
	ami = var.AMI[var.REGION]
	instance_type = "t2.micro"
	availability_zone = var.ZONE1
	key_name = aws_key_pair.k8s-key.key_name
	vpc_security_group_ids = ["sg-08ed8b6a4cbe5fc81"]
	tags = {
		Name = "Test-instance"
	}

	provisioner "file" {
	  source = "data/script.sh"
	  destination = "/tmp/script.sh"
	}

	provisioner "remote-exec" {
		inline = [
			"chmod +x /tmp/script.sh",
			"sudo /tmp/script.sh"
		]	  
	}

	connection {
	  user = var.USER
	  private_key = file("data/id_rsa")
	  host = self.public_ip
	}
}
