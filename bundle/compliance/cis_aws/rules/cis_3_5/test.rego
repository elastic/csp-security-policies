package compliance.cis_aws.rules.cis_3_5

import data.cis_aws.test_data
import data.compliance.cis_aws.data_adapter
import data.compliance.policy.aws_config.ensure_config_enabled as audit
import data.lib.test

finding = audit.finding

test_violation {
	eval_fail with input as rule_input(false, false)
	eval_fail with input as rule_input(true, false)
	eval_fail with input as rule_input(false, true)
}

test_pass {
	eval_pass with input as rule_input(true, true)
}

test_not_evaluated {
	not_eval with input as test_data.not_evaluated_trail
}

rule_input(all_supported_enabled, include_global_resource_types_enabled) = test_data.generate_aws_configservice_recorders(all_supported_enabled, include_global_resource_types_enabled)

eval_fail {
	test.assert_fail(finding) with data.benchmark_data_adapter as data_adapter
}

eval_pass {
	test.assert_pass(finding) with data.benchmark_data_adapter as data_adapter
}

not_eval {
	not finding with data.benchmark_data_adapter as data_adapter
}