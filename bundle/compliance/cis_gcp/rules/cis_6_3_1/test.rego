package compliance.cis_gcp.rules.cis_6_3_1

type := "cloud-sql"
subtype := "gcp-sql-instance"

test_violation {
	eval_fail with input as test_data.generate_gcp_asset(type, subtype, {"settings": {"databaseFlags": [{"name": "external scripts enabled", "value": "on"}]}}, {})
}

test_pass {
	eval_pass with input as test_data.generate_gcp_asset(type, subtype, {}, {})
	eval_pass with input as test_data.generate_gcp_asset(type, subtype, {"settings": {"databaseFlags": []}}, {})
	eval_pass with input as test_data.generate_gcp_asset(type, subtype, {"settings": {"databaseFlags": [{"name": "external scripts enabled", "value": "off"}]}}, {})
}

test_not_evaluated {
	not_eval with input as test_data.not_eval_resource
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
