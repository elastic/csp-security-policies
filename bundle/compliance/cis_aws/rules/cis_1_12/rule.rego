package compliance.cis_aws.rules.cis_1_12

import data.compliance.lib.common
import data.compliance.policy.aws_iam.data_adapter
import data.compliance.policy.aws_iam.ensure_credentials_use as audit

finding = result {
	# filter
	data_adapter.is_iam_user

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.ensure_credentials_use),
		{"IAM User:": data_adapter.iam_user},
	)
}
