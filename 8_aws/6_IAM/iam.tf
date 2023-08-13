resource "aws_iam_group" "administrators" {
  name = "administrators"
}

resouce "aws_iam_policy_attachment" "administrators" {
  name       = "administrators"
  groups     = [aws_iam_group.administrators.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#user
resource "aws_iam_user" "admin1" {
  name = "admin1"
}

resource "aws_iam_user" "admin2" {
  name = "admin2"
}

resource "aws_iam_group_membership" "administrators-users" {
  name  = "administrators-users"
  users = [aws_iam_user.admin1.name, aws_iam_user.admin2.name]
  group = aws_iam_group.administrators.name

}


resource "aws_iam_role" "s3-mybucket-role" {
  name               = "s3-mybucket-role"
  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": ["s3.amazonaws.com"]
            },
            "Effect": "Allow",
            "Sid": ""
            }
        ]
    }
EOF
}

resource "aws_iam_instance_profile" "s3-mybucket-role-instaceprofile" {
  name = "s3-mybucket-role"
  role = aws_iam_role.s3-mybucket-role.name
}


resource "aws_iam_role_policy" "s3-mybucket-role-policy" {
  name   = "s3-mybucket-role-policy"
  role   = aws_iam_role.s3-mybucket-role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": [
            "s3:*"
        ],
        "Effect": "Allow",
        "Resource": [
            "arn:aws:s3:::mybucket-c29df1",
            "arn:aws:s3:::mybucket-c29df1/*"
        ]
        }
    ]
}
EOF

}
