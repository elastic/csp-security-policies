package compliance.policy.aws_iam.data_adapter

is_pwd_policy {
	input.subType == "aws-password-policy"
}

is_iam_user {
	input.subType == "aws-iam-user"
	not input.resource.name == "<root_account>"
}

is_root_account {
	input.subType == "aws-iam-user"
	input.resource.name == "<root_account>"
}

pwd_policy = policy {
	is_pwd_policy
	policy := input.resource
}

iam_user = user {
	is_iam_user
	user := input.resource
}

used_active_access_keys = {access_key |
    print("lalalala", iam_user.access_keys)
	access_key = iam_user.access_keys[_]
	access_key.active
	access_key.has_used
}

unused_active_access_keys = {access_key |
	access_key = iam_user.access_keys[_]
	access_key.active
	not access_key.has_used
}

active_access_keys := used_active_access_keys | unused_active_access_keys
