package compliance.policy.aws_iam.ensure_enabled_mfa

import data.compliance.policy.aws_iam.data_adapter

default ensure_mfa_device = false

ensure_mfa_device {
	count(data_adapter.iam_user.mfa_devices) > 0
	data_adapter.iam_user.password_enabled
}
