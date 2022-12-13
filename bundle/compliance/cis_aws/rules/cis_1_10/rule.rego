package compliance.cis_aws.rules.cis_1_10

import data.compliance.lib.common
import data.compliance.policy.aws_iam.data_adapter

# Ensure multi-factor authentication (MFA) is enabled for all IAM users that have a console password.
rule_evaluation {
	count(data_adapter.iam_user.MFADevices) > 0
	data_adapter.iam_user.HasLoggedIn
}

finding = result {
	# filter
	data_adapter.is_iam_user

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(rule_evaluation),
		{"IAM User:": data_adapter.iam_user}
	)
}