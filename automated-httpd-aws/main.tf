provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "allow_http" {
    name = "allow_http"
    description = "allow http traffic only"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "aws_linux" {
    ami = "ami-00c39f71452c08778"
    instance_type = "t2.micro"
    user_data = file("httpd.sh")
    vpc_security_group_ids = [
        aws_security_group.allow_http.id
    ]
}

output "public_ip" {
    value = aws_instance.aws_linux.public_ip
}