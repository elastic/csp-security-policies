package compliance.cis_aws.rules.cis_1_20

import data.compliance.cis_aws.data_adapter
import data.lib.test

generate_input(analyzers) = {
	"resource": {
		"Analyzers": analyzers,
		"Region": "eu-west-1",
	},
	"subType": "aws-region-accessanalyzers",
	"type": "identity-management",
}

test_violation {
	eval_fail with input as generate_input(null)
	eval_fail with input as generate_input([])
	eval_fail with input as generate_input([{"Arn": "some-arn"}])
	eval_fail with input as generate_input([{
		"Arn": "some-arn",
		"Status": "FOO",
	}])
}

test_pass {
	eval_pass with input as generate_input([{
		"Arn": "some-arn",
		"Status": "ACTIVE",
	}])
	eval_pass with input as generate_input([
		{
			"Arn": "some-arn",
			"Status": "ACTIVE",
		},
		{
			"Arn": "some-arn",
			"Status": "FOO",
		},
	])
}

test_not_evaluated {
	not_eval with input as {}
	not_eval with input as {"resource": {"Analyzers": []}} # No subType
}

eval_fail {
	test.assert_fail(finding) with data.benchmark_data_adapter as data_adapter
}

eval_pass {
	test.assert_pass(finding) with data.benchmark_data_adapter as data_adapter
}

not_eval {
	not finding with data.benchmark_data_adapter as data_adapter
}
