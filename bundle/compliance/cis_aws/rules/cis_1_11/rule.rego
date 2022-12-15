package compliance.cis_aws.rules.cis_1_11

import data.compliance.lib.common
import data.compliance.policy.aws_iam.data_adapter

default rule_evaluation = true

# Do not setup access keys during initial user setup for all IAM users that have a console password.
rule_evaluation = false {
	data_adapter.iam_user.HasLoggedIn
	key := data_adapter.active_access_keys[_]
	not key.HasUsed
}

finding = result {
	# filter
	data_adapter.is_iam_user

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(rule_evaluation),
		{"IAM User:": data_adapter.iam_user},
	)
}
