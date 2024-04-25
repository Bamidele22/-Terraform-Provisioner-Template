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
    vpc_security_group_ids = [""]

    tags = {
      Name = "Dove-Instance"
      Project = "Dove"
    }
# the file provisioner is used to upload files to the remote machine.
    provisioner "file" {
      source = "web.sh"
      destination = "/tmp/web.sh"
    }

# this is used to execute command on the remote machine i.e the EC2 instance we'll be launching
    provisioner "remote-exec" {
      inline = [ 
        "chmod  u+x /tmp/web.sh",
        "sudo /tmp/web.sh"
       ]
    }

# Tell terraform to use this user and P.key to login and to use the public IP address of the EC2.instance.
    connection {
      user = var.USER
      private_key = file("dovekey")
      host = self.public_ip
    }
}