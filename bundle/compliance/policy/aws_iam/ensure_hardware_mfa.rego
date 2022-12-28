package compliance.policy.aws_iam.ensure_hardware_mfa

import data.compliance.policy.aws_iam.data_adapter

default ensure_hardware_device = false

ensure_hardware_device {
	data_adapter.iam_user.mfa_active
	device := data_adapter.iam_user.mfa_devices[_]
	not device.is_virtual
}
