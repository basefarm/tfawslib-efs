resource "aws_efs_file_system" "fs" {
    tags {
        CostCenter = "${var.costcenter}"
        Name            = "${var.nameprefix}"
    }
    performance_mode = "${var.performance_mode}"
}

resource "aws_efs_mount_target" "mount" {
#    count = "${length(var.subnets)}"
    count = "${var.subnetcount}"
    file_system_id = "${aws_efs_file_system.fs.id}"
    subnet_id = "${element(var.subnets , count.index ) }"
    security_groups = ["${aws_security_group.sg.id}"]
}

resource "aws_security_group" "sg" {
    tags {
        CostCenter = "${var.costcenter}"
        Name       = "${var.nameprefix}-efs"
    }
    name = "${var.nameprefix}-EFS-access"
    description = "Allows access to EFS ${var.nameprefix}"
    vpc_id = "${var.vpc}"
}
resource "aws_security_group_rule" "sg_egress_01" {
  security_group_id = "${aws_security_group.sg.id}"
  type            = "egress"
  from_port       = "0"
  to_port         = "0"
  protocol        = "-1"
  source_security_group_id = "${aws_security_group.sg.id}"
}
resource "aws_security_group_rule" "sg_ingress_01" {
  security_group_id = "${aws_security_group.sg.id}"
  type            = "ingress"
  from_port       = "0"
  to_port         = "0"
  protocol        = "-1"
  source_security_group_id = "${aws_security_group.sg.id}"
}
output "id" { value = "${aws_efs_file_system.fs.id}" }
output "sg" { value = "${aws_security_group.sg.id}" }
