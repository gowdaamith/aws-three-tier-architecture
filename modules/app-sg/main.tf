data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow" 
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
        
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "backend" {
  name =  "${var.project_name}-${var.environment}-backend-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
  tags = {
    Name = "${var.project_name}-${var.environment}-backend-role"
  }
}

data "aws_iam_policy_document" "database_secret" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resource = [ var.database_secret_arn ]
  }
}

resource "aws_iam_policy" "database_secret" {
  name = "${var.project_name}-${var.environment}-read-db-secret"
  description = "Allows backend Ec2 instances  to read the database  secret form  the aws secret manager" 
  policy = data.aws_iam_policy_document.database_secret.json
  tags ={
    name = "${var.project_name)-${var.environment}-read-db-secret"
  }
}

resource "aws_iam_role_policy_attachment" "database_secret" {
  role = aws_iam_role.backend.name
  policy_arn = aws_iam_policy.database_secret.arn
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role = aws_iam_role.backend.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "backend" {

  name = "${var.project_name}-${var.environment}-backend-profile"

  role = aws_iam_role.backend.name

  tags = {
    Name = "${var.project_name}-${var.environment}-backend-profile"
  }
}


# -------------------------------------------
# EC2 Launch Template
# -------------------------------------------


resource "aws_launch_template" "backend" {
  name = "${var.project_name}-${var.environments}-launch-template" 
  image_id = var.ami_id
  instance_type =var.instance_type
  vpc_security_group_idsd = [ var.app_security_group_id ]
  iam_instance_profile {
    arn = aws_iam_instance_profile.backend.arn
  }
  lifecycle {
    create_before_destroy = true
  }
}  
  
