resource "aws_instance" "web" {
  ami           = "ami-0b898040803850657"
  instance_type = "t2.micro"
  key_name      = "dns"
  subnet_id     = "${aws_subnet.public1.id}"

  vpc_security_group_ids = ["${aws_security_group.sg_22.id}"]


  tags = {
    Name = "terraform"
  }
  user_data = "${data.template_file.user_data.rendered}"
}
data "template_file" "user_data" {
  template = "${file("templates/user_data.tpl")}"
}