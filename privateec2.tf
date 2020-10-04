resource "aws_instance" "db" {
  ami           = "ami-0b898040803850657"
  instance_type = "t2.micro"
  key_name      = "dns"
  subnet_id     = "${aws_subnet.private1.id}"

  #user_data     = "${file("installhttpd.sh")}"
  vpc_security_group_ids = ["${aws_security_group.sg_22.id}"]

  tags = {
    Name = "terraform-private"
  }
  user_data = "${data.template_file.user_data.rendered}"
}
data "template_file" "user_data2" {
  template = "${file("template/user_data.tpl")}"
}
