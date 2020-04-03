resource "aws_vpc" "vpc" {
    cidr_block              = "${var.vpc_cidr}"
    enable_dns_hostnames    = true
    enable_dns_support      = true
    tags = {
        Name                = "Demo-VPC"
    }
}
resource "aws_subnet" "public_subnets" {
    cidr_block              = "${var.PublicSubnetCidrs}"
    vpc_id                  = "${aws_vpc.vpc.id}"
    map_public_ip_on_launch = true
    tags = {
        Name                = "${var.prefix}-Public"
    }
}
resource "aws_internet_gateway" "igw" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    tags = {
        Name                = "${var.prefix}-IGW"
    }
}
resource "aws_route_table" "Public_rt" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    route {
        cidr_block          = "0.0.0.0/0"
        gateway_id          = "${aws_internet_gateway.igw.id}"
    }
    tags = {
        Name                = "${var.prefix}-Public-RT"
    }
}

resource "aws_route_table_association" "public_ass" {
    subnet_id               = "${aws_subnet.public_subnets.id}"            
    route_table_id          = "${aws_route_table.Public_rt.id}"
}
resource "aws_security_group" "ad_sg" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    name                    = "${var.prefix}-ADDS"
    description             = "Security Group attached to server"

    ingress {
        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }

    ingress {
        from_port           = 80
        to_port             = 80
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }

    ingress {
        from_port           = 443
        to_port             = 443
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }

    egress {
        from_port               = 0
        to_port                 = 0
        protocol                = "-1"
        cidr_blocks             = ["0.0.0.0/0"]

    }

    tags = {
        Name                = "${var.prefix}-demo-sg"
    }
}
resource "aws_instance" "linuxserver" {
    instance_type           = "${var.InstanceType}"
    key_name                = "${var.key_name}"
    ami                     = "${var.Ami_Id}"
    subnet_id               = "${aws_subnet.public_subnets.id}"
    monitoring              = true
    vpc_security_group_ids  = [
        "${aws_security_group.ad_sg.id}"
    ]
    
    root_block_device {
        volume_size          = 8
        volume_type          = "gp2"
        delete_on_termination= true
    }
    tags = {
        Name                 = "${var.prefix}DC02"
    }
    connection {
        host = "${aws_instance.linuxserver.public_ip}"
   	type = "ssh"
    	user = "ubuntu"
    	private_key = "${file("/DemoUS/DemoUS-master/DemoUS/ec2/demo.pem")}"
    }

     provisioner "remote-exec" {
    	inline = [
	  "sudo apt-get update"
        ]
     }
}

