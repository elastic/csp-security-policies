package compliance.cis_aws.rules.cis_1_16

import data.compliance.lib.common
import data.compliance.policy.aws_iam.data_adapter

# Ensure IAM policies that allow full "*:*" administrative privileges are not attached
finding = result {
	# filter
	data_adapter.is_iam_policy

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(count(fails) == 0),
		{"Statements": statement},
	)
}

statement := data_adapter.policy_document.Statement

allowed[x] {
	statement[x].Effect == "Allow"
}

wildchar_action[x] {
	some i
	statement[x].Action[i] == "*"
}

wildchar_action[x] {
	statement[x].Action == "*"
}

wildchar_resource[x] {
	statement[x].Resource == "*"
}

# Resources can also be a list
wildchar_resource[x] {
	some i
	statement[x].Resource[i] == "*"
}

fails[x] {
	allowed[x]
	wildchar_action[x]
	wildchar_resource[x]
}
