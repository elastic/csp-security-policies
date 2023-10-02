package compliance.cis_azure.rules.cis_3_10

import data.cis_azure.test_data
import data.compliance.policy.azure.data_adapter
import data.lib.test

test_violation {
	eval_fail with input as test_data.generate_storage_account_with_property("privateEndpointConnections", [{"properties": {"privateLinkServiceConnectionState": {"status": "NotApproved"}}}])
}

test_pass {
	eval_pass with input as test_data.generate_storage_account_with_property("privateEndpointConnections", [{"properties": {"privateLinkServiceConnectionState": {"status": "Approved"}}}])
}

test_not_evaluated {
	not_eval with input as test_data.not_eval_storage_account_empty
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
