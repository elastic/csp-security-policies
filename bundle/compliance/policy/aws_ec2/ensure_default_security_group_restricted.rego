package compliance.policy.aws_ec2.ensure_default_security_group_restricted

import data.compliance.lib.common
import data.compliance.policy.aws_ec2.data_adapter

default rule_evaluation = false

finding = result {
	# filter 
	data_adapter.is_security_group_policy

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(rule_evaluation),
		input.resource,
	)
}

rule_evaluation {
	data_adapter.default_security_group_restricted
}
