package compliance.cis_gcp.rules.cis_2_1

import data.cis_gcp.test_data
import data.compliance.policy.gcp.data_adapter
import data.lib.test

test_violation {
	# fail when no read/write logs are set for project/folder/org level
	eval_fail with input as test_data.generate_policies_asset([{}])

	# fail when DATA_WRITE is missing from project
	eval_fail with input as test_data.generate_policies_asset([{"iam_policy": {"audit_configs": [{
		"audit_log_configs": [{"log_type": 2}],
		"service": "allServices",
	}]}}])

	# fail when DATA_READ is missing from project
	eval_fail with input as test_data.generate_policies_asset([{"iam_policy": {"audit_configs": [{
		"audit_log_configs": [{"log_type": 3}],
		"service": "allServices",
	}]}}])

	# fail when extempted members is not empty
	eval_fail with input as test_data.generate_policies_asset([{"iam_policy": {"audit_configs": [{
		"audit_log_configs": [{"log_type": 3, "exempted_members": ["user:a"]}, {"log_type": 2}],
		"service": "allServices",
	}]}}])

	# fail when "service": "allServices" is missing from project
	eval_fail with input as test_data.generate_policies_asset([{"iam_policy": {"audit_configs": [{"audit_log_configs": [{"log_type": 3}, {"log_type": 2}]}]}}])

	# fail when DATA_READ and DATA_WRITE aren't set on the same policy
	eval_fail with input as test_data.generate_policies_asset([
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [{"log_type": 3}],
			"service": "allServices",
		}]}},
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [{"log_type": 2}],
			"service": "allServices",
		}]}},
	])
}

test_pass {
	# passes when project has DATA_READ/DATA_WRITE for all services
	eval_pass with input as test_data.generate_policies_asset([
		# project policies
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [
				{"log_type": 3},
				{"log_type": 2},
			],
			"service": "allServices",
		}]}},
		# folder policies
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [{"log_type": 2}],
			"service": "allServices",
		}]}},
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [{"log_type": 3}],
			"service": "allServices",
		}]}},
		# org policies
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [{"log_type": 3}],
			"service": "allServices",
		}]}},
	])

	# passes when an org has DATA_READ/DATA_WRITE for all services
	eval_pass with input as test_data.generate_policies_asset([
		# project config without DATA_READ
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [{"log_type": 2}],
			"service": "allServices",
		}]}},
		# folder config without DATA_WRITE
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [{"log_type": 3}],
			"service": "allServices",
		}]}},
		# org config with both
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [
				{"log_type": 3},
				{"log_type": 2},
			],
			"service": "allServices",
		}]}},
	])

	# passes when a folder has DATA_READ/DATA_WRITE for all services
	eval_pass with input as test_data.generate_policies_asset([
		# project config without DATA_READ
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [{"log_type": 2}],
			"service": "allServices",
		}]}},
		# folder config with both (2nd item)
		{"iam_policy": {"audit_configs": [{"audit_log_configs": [{"log_type": 3}]}]}},
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [
				{"log_type": 3},
				{"log_type": 2},
			],
			"service": "allServices",
		}]}},
		# org config without DATA_WRITE
		{"iam_policy": {"audit_configs": [{
			"audit_log_configs": [{"log_type": 3}],
			"service": "allServices",
		}]}},
	])
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
