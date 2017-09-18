data "template_file" "student-cloudinit" {
  template = "${file("./student-cloudinit.tpl")}"
}

resource "cloudca_instance" osa-aio-node {
   environment_id="${var.environment_id}"
   count="${var.student_count}"
   name="student-on-${count.index}-osa-aio"
   network_id="${var.network_id}"
   template="Ubuntu 16.04.02 HVM"
   compute_offering="8vCPU.16GB"
   ssh_key_name="${var.key_name}"
   user_data="${data.template_file.student-cloudinit.rendered}"
   root_volume_size_in_gb=25
}

resource "cloudca_volume" osa-aio_osd1 {
   environment_id="${var.environment_id}"
   count="${var.student_count}"
   disk_offering="100GB - 500 IOPS Min."
   name="${element(cloudca_instance.osa-aio-node.*.name, count.index)}_OSD1"
   instance_id="${element(cloudca_instance.osa-aio-node.*.id, count.index)}"
}

resource "cloudca_public_ip" "my_publicip" {
   environment_id = "${var.environment_id}"
   vpc_id = "${var.vpc_id}"
   count="${var.student_count}"
}
