package compliance.cis_gcp.rules.cis_1_10

import data.cis_gcp.test_data
import data.compliance.cis_aws.data_adapter
import data.compliance.lib.common
import data.lib.test

test_violation {
	eval_fail with input as rule_input(null, "91d", common.current_date)
	eval_fail with input as rule_input(null, "89d", common.past_date)
	eval_fail with input as rule_input(null, "7776001s", common.current_date)
	eval_fail with input as rule_input(null, "7776000s", common.past_date)
	eval_fail with input as rule_input(null, "48h", common.past_date)
}

test_pass {
	eval_pass with input as rule_input(null, "90d", common.current_date)
	eval_pass with input as rule_input(null, "7776000s", common.current_date)
}

test_not_evaluated {
	not_eval with input as test_data.not_eval_resource
}

rule_input(members, rotationPeriod, nextRotationTime) = test_data.generate_kms_resource(members, rotationPeriod, nextRotationTime)

eval_fail {
	test.assert_fail(finding) with data.benchmark_data_adapter as data_adapter
}

eval_pass {
	test.assert_pass(finding) with data.benchmark_data_adapter as data_adapter
}

not_eval {
	not finding with data.benchmark_data_adapter as data_adapter
}
