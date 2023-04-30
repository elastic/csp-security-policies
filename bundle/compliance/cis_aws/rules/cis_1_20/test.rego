package compliance.cis_aws.rules.cis_1_20

import data.compliance.cis_aws.data_adapter
import data.lib.test

generate_input(analyzers) = {
	"type": "identity-management",
	"subType": "aws-access-analyzers",
	"resource": {"RegionToAccessAnalyzers": analyzers},
}

analyzer(arn, status) = {
	"Arn": arn,
	"CreatedAt": "2023-01-09T15:06:39Z",
	"Name": "Analyzer",
	"Status": status,
	"Type": "ACCOUNT",
	"Tags": {},
}

test_violation {
	eval_fail({"region-1"}) with input as generate_input({"region-1": [analyzer("some-arn", null)]})
	eval_fail({"region-1"}) with input as generate_input({"region-1": [analyzer("some-arn", "FOO")]})
	eval_fail({"region-2"}) with input as generate_input({
		"region-1": [analyzer("some-arn", "ACTIVE")],
		"region-2": [], # no analyzer in some region
	})
	eval_fail({"region-2"}) with input as generate_input({
		"region-1": [analyzer("some-arn", "ACTIVE")],
		"region-2": [analyzer("invalid-status", "FOO")],
	})

	# Multiple regions in evidence
	eval_fail({"region-1", "region-3", "region-4"}) with input as generate_input({
		"region-1": [analyzer("invalid-status", "FOO")],
		"region-2": [{}, analyzer("some-arn", "ACTIVE"), analyzer("invalid-status", "FOO")],
		"region-3": [analyzer("some-arn", null)],
		"region-4": [],
	})
}

test_pass {
	# no regions, no problems
	eval_pass with input as generate_input(null)
	eval_pass with input as generate_input([])
	eval_pass with input as generate_input({"region-1": [analyzer("some-arn", "ACTIVE")]})
	eval_pass with input as generate_input({
		"region-1": [analyzer("some-arn", "ACTIVE")],
		"region-2": [analyzer("invalid-status", "FOO"), analyzer("some-other-arn", "ACTIVE")],
	})
}

test_not_evaluated {
	not_eval with input as {}
	not_eval with input as {"resource": {"RegionToAccessAnalyzers": []}} # No subType
}

eval_fail(failed_regions) {
	test.assert_fail(finding) with data.benchmark_data_adapter as data_adapter
	finding.evidence["Regions without access analyzers"] == failed_regions
}

eval_pass {
	test.assert_pass(finding) with data.benchmark_data_adapter as data_adapter
}

not_eval {
	not finding with data.benchmark_data_adapter as data_adapter
}
