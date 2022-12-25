package compliance.policy.aws_iam.validate_credentials

import data.compliance.lib.assert
import data.compliance.policy.aws_iam.data_adapter

duration = sprintf("%dh", [45 * 24]) # 45 days converted to hours

default validate_credentials = false

validate_credentials {
	assert.array_is_empty(data_adapter.active_access_keys)
	data_adapter.iam_user.password_enabled
	data_adapter.are_credentials_valid([data_adapter.iam_user], "last_access", duration)
}

validate_credentials {
	not data_adapter.iam_user.password_enabled
	validate_access_keys
}

validate_credentials {
	data_adapter.iam_user.password_enabled
	data_adapter.are_credentials_valid([data_adapter.iam_user], "last_access", duration)
	validate_access_keys
}

validate_credentials {
	data_adapter.iam_user.password_enabled
	data_adapter.iam_user.last_access == "No_Information"
	data_adapter.are_credentials_valid([data_adapter.iam_user], "password_last_changed", duration)
	validate_access_keys
}

validate_access_keys {
	data_adapter.are_credentials_valid(data_adapter.used_active_access_keys, "last_access", duration)
	data_adapter.are_credentials_valid(data_adapter.unused_active_access_keys, "rotation_date", duration)
}
