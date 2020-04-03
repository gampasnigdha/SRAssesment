output "publicip" {
  value = "${aws_instance.linuxserver.public_ip}"
}

