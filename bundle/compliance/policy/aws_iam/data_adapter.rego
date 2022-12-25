package compliance.policy.aws_iam.data_adapter

import future.keywords.every
import data.compliance.lib.common

date_format = "2006-01-02 15:04:05.999999999 -0700 MST"

is_pwd_policy {
	input.subType == "aws-password-policy"
}

is_iam_user {
	input.subType == "aws-iam-user"
	not input.resource.name == "<root_account>"
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
	access_key = iam_user.access_keys[_]
	access_key.active
	access_key.has_used
}

unused_active_access_keys = {access_key |
	access_key = iam_user.access_keys[_]
	access_key.active == true
	not access_key.has_used
}

are_credentials_valid(keys, field, duration) {
	every key in keys {
		common.date_diff(time.parse_ns(date_format, key[field]), duration)
	}
}

active_access_keys := used_active_access_keys | unused_active_access_keys