package compliance.cis_aws.rules.cis_1_7

import data.compliance.lib.common
import data.compliance.policy.aws_iam.common as iam_common
import data.compliance.policy.aws_iam.data_adapter

default rule_evaluation = false

# Eliminate use of the 'root' user for administrative and daily tasks
finding = result {
	# filter
	data_adapter.is_root_user

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(rule_evaluation),
		{"IAM User:": data_adapter.iam_user},
	)
}

rule_evaluation {
	not iam_common.are_credentials_within_duration(data_adapter.active_access_keys, "last_access", "24h")
	not iam_common.are_credentials_within_duration([data_adapter.iam_user], "last_access", "24h")
}

rule_evaluation {
	count(data_adapter.active_access_keys) == 0
	not iam_common.are_credentials_within_duration([data_adapter.iam_user], "last_access", "24h")
}
