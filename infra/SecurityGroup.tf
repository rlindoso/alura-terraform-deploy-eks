resource "aws_security_group" "ssh_cluster" {
  name        = "ssh_cluster"
  description = "ssh_cluster EKS"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ingress_ssh_cluster" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh_cluster.id
}

resource "aws_security_group_rule" "egress_ssh_cluster" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh_cluster.id
}

resource "aws_security_group" "private" {
  name        = "private-ecs"
  description = "Application Load Balance ECS"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ingress-private-ecs" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = aws_security_group.alb.id
  security_group_id = aws_security_group.private.id
}

resource "aws_security_group_rule" "egress-private-ecs" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private.id
}
