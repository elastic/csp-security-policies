package compliance.cis_aws.rules.cis_1_9

import data.compliance.policy.aws_iam.data_adapter
import data.compliance.lib.common

default rule_evaluation = false

# Ensure that the number of previous passwords that IAM users are prevented from reusing is 24.
finding = result {
	# filter
    data_adapter.is_pwd_policy

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(data_adapter.pwd_policy.ReusePreventionCount == 24),
		{"Password Policy:": data_adapter.pwd_policy}
	)
}
