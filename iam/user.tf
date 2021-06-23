# User for the ops
/*resource "aws_iam_user" "ops" {
  name = "ops"
}
resource "aws_iam_user_policy_attachment" "ops_admin_access" {
  user       = aws_iam_user.ops.name
  policy_arn = data.aws_iam_policy.administrator_access.arn
}

# User for the application 1 developpers
resource "aws_iam_user_policy_attachment" "dev_app_1_admin_access" {
  user       = aws_iam_user.dev_app_1.name
  policy_arn = data.aws_iam_policy.administrator_access.arn
}
resource "aws_iam_user" "dev_app_1" {
  name = "dev_app_1"
}

# User for the application 2 developpers
resource "aws_iam_user" "dev_app_2" {
  name = "dev_app_2"
}
resource "aws_iam_user_policy_attachment" "dev_app_2_admin_access" {
  user       = aws_iam_user.dev_app_2.name
  policy_arn = data.aws_iam_policy.administrator_access.arn
}*/

# Account for user which have to access AWS
resource "aws_iam_user" "adrien_loyer" {
  name = "adrien.loyer"
}

resource "aws_iam_user" "philippe_blanquet" {
  name = "philippe.blanquet"
}

resource "aws_iam_user" "bernard_darmont" {
  name = "bernard.darmont"
}

resource "aws_iam_user" "alfred_arcens" {
  name = "alfred.arcens"
}

resource "aws_iam_user" "regis_roland" {
  name = "regis.roland"
}

resource "aws_iam_user" "agnais_solari" {
  name = "agnais.solari"
}