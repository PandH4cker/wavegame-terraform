# Group for all the collaborators
/*resource "aws_iam_group" "team" {
  name = "team"
}

resource "aws_iam_group_membership" "team" {
  name = "team-group-membership"
  group = aws_iam_group.team.name
  users = [
    aws_iam_user.ops.name,
    aws_iam_user.dev_app_1.name,
    aws_iam_user.dev_app_2.name,
  ]
}*/

# Groups
resource "aws_iam_group" "administrators" {
  name = "administrators"
}

resource "aws_iam_group" "stream_team" {
  name = "stream_app"
}

resource "aws_iam_group" "subscription_team" {
  name = "subscription_team"
}

# Group Membership
resource "aws_iam_group_membership" "administrators" {
  name = "administrators-group-membership"
  group = aws_iam_group.administrators.name
  users = [
    aws_iam_user.adrien_loyer.name,
    aws_iam_user.philippe_blanquet.name
  ]
}

resource "aws_iam_group_membership" "stream_team" {
  name = "stream-team-group-membership"
  group = aws_iam_group.stream_team.name
  users = [
    aws_iam_user.bernard_darmont.name,
    aws_iam_user.alfred_arcens.name
  ]
}

resource "aws_iam_group_membership" "subscription_team" {
  name = "subscription-team-group-membership"
  group = aws_iam_group.subscription_team.name
  users = [
    aws_iam_user.regis_roland.name,
    aws_iam_user.agnais_solari.name
  ]
}

# Groups AuthZ
resource "aws_iam_group_policy_attachment" "administrators_access" {
  group       = aws_iam_group.administrators.name
  policy_arn = data.aws_iam_policy.administrator_access.arn
}

resource "aws_iam_group_policy_attachment" "subscription_team_access" {
  group       = aws_iam_group.subscription_team.name
  policy_arn = aws_iam_policy.subscription_app_policy.arn
}

resource "aws_iam_group_policy_attachment" "stream_team_access" {
  group       = aws_iam_group.stream_team.name
  policy_arn = aws_iam_policy.stream_app_policy.arn
}