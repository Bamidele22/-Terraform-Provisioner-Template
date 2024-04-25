resource "aws_key_pair" "dove-key" {

    key_name = "dovekey"
    public_key = file("dovekey.pub")
}

# the resource instance is used to provision an aws instance with (ami, etc.)
resource "aws_instance" "dove-instance" {
    ami = var.AMIS[var.REGION]
    instance_type = "t2.micro"
    availability_zone = var.ZONE1
    key_name = aws_key_pair.dove-key.key_name
    vpc_security_group_ids = ["sg-"]

    tags = {
      Name = "Dove-Instance"
      Project = "Dove"
    }
# the file provisioner is used to upload files to the remote machine.
    provisioner "file" {
      source = "web.sh"
      destination = "/tmp/web.sh"
    }

# this is used to execute command on the remote machine.
    provisioner "remote-exec" {
      
    }

# this is used to establish a connection.
    connection {
      user = var.USER
      private_key = file("dovekey")
      host = self.public_ip
    }
}