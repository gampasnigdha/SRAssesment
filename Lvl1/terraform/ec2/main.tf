module "linuxserver" {
  source = "/DemoUS/DemoUS-master/DemoUS/ec2/linuxserver"
}

resource "null_resource" "sleep" {
   depends_on = ["module.linuxserver"]
    provisioner "local-exec" {
        command = "sleep 60"
    }
}

resource "null_resource" "ansible" {
    depends_on = ["null_resource.sleep"]

    provisioner "local-exec" {
        command = "sudo echo '[ec2]' > /DemoUS/DemoUS-master/DemoUS/ec2/inventory;sudo echo '${module.linuxserver.publicip} ansible_ssh_user=ubuntu ansible_ssh_key=/DemoUS/DemoUS-master/DemoUS/ec2/demo.pem' >> /DemoUS/DemoUS-master/DemoUS/ec2/inventory"
    }
}

resource "null_resource" "ansible1" {

    depends_on = ["null_resource.ansible"]

    provisioner "local-exec" {
        command = "export ANSIBLE_HOST_KEY_CHECKING=False;ansible-playbook deploy.yaml -i /DemoUS/DemoUS-master/DemoUS/ec2/inventory"
    }
}



