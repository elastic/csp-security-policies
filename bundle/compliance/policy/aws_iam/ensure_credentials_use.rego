package compliance.policy.aws_iam.ensure_credentials_use

import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.policy.aws_iam.data_adapter
import future.keywords.every

duration = sprintf("%dh", [45 * 24]) # 45 days converted to hours

date_format = "2006-01-02 15:04:05.999999999 -0700 MST"

default ensure_credentials_use = false

ensure_credentials_use {
	assert.array_is_empty(data_adapter.active_access_keys)
	are_credentials_valid([data_adapter.iam_user])
}

ensure_credentials_use {
	are_credentials_valid(data_adapter.active_access_keys)
	are_credentials_valid([data_adapter.iam_user])
}

are_credentials_valid(keys) {
	every key in keys {
		common.date_diff(time.parse_ns(date_format, key.LastAccess), duration)
	}
}
