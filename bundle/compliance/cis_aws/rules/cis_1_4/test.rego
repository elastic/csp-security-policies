package compliance.cis_aws.rules.cis_1_4

import data.cis_aws.test_data
import data.compliance.cis_aws.data_adapter
import data.lib.test

test_violation {
    eval_fail with input as rule_input([{"active": true, "has_used": true}], "", "")
	# eval_fail with input as rule_input([{"active": false, "has_used": true}, {"active": true, "has_used": false}], "", "")
}

# test_pass {
	# eval_pass with input as rule_input([{"active": false, "has_used": true}], "", "")
	# eval_pass with input as rule_input([{"active": false, "has_used": true}, {"active": false, "has_used": true}], "", "")
# }

test_not_evaluated {
	not_eval with input as test_data.not_evaluated_iam_user
}

rule_input(access_keys, last_access, password_last_changed) = test_data.generate_root_user(access_keys, last_access, password_last_changed)

eval_fail {
	test.assert_fail(finding) with data.benchmark_data_adapter as data_adapter
}

eval_pass {
	test.assert_pass(finding) with data.benchmark_data_adapter as data_adapter
}

not_eval {
	not finding with data.benchmark_data_adapter as data_adapter
}
