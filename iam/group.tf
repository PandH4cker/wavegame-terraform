# Group for all the collaborators
resource "aws_iam_group" "team" {
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
}