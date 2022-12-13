package compliance.cis_aws.rules.cis_1_13

import data.cis_aws.test_data
import data.compliance.cis_aws.data_adapter
import data.lib.test

test_violation {
    eval_fail with input as rule_input([{"AccessKeyId":"test", "Active": true}, {"AccessKeyId":"test2", "Active": true}])
}

test_pass {
	eval_pass with input as rule_input([])
	eval_pass with input as rule_input([{"AccessKeyId":"test", "Active": true}])
	eval_pass with input as rule_input([{"AccessKeyId":"test", "Active": false}, {"AccessKeyId":"test2", "Active": false}])
    eval_pass with input as rule_input([{"AccessKeyId":"test", "Active": true}, {"AccessKeyId":"test2", "Active": false}])
}

test_not_evaluated {
	not_eval with input as test_data.not_evaluated_input
}

rule_input(access_keys) = test_data.generate_iam_user(access_keys)

eval_fail {
	test.assert_fail(finding) with data.benchmark_data_adapter as data_adapter
}

eval_pass {
	test.assert_pass(finding) with data.benchmark_data_adapter as data_adapter
}

not_eval {
	not finding with data.benchmark_data_adapter as data_adapter
}
