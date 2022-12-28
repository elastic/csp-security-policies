package compliance.cis_aws.rules.cis_1_6

import data.compliance.lib.common
import data.compliance.policy.aws_iam.data_adapter
import data.compliance.policy.aws_iam.ensure_hardware_mfa as audit

# Ensure that there is only a single active access key per user.
finding = result {
	# filter
	data_adapter.is_root_user

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.ensure_hardware_device),
		{"IAM User:": data_adapter.iam_user},
	)
}
