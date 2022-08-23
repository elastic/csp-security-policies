package compliance.cis_k8s.rules.cis_4_2_1

import data.compliance.cis_k8s.data_adapter
import data.kubernetes_common.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("") with data.benchmark_data_adapter as data_adapter
	test.assert_fail(finding) with input as rule_input("--anonymous-auth=true") with data.benchmark_data_adapter as data_adapter
	test.assert_fail(finding) with input as rule_input_with_external("--anonymous-auth=true", create_process_config(true)) with data.benchmark_data_adapter as data_adapter
	test.assert_fail(finding) with input as rule_input_with_external("--anonymous-auth=true", create_process_config(false)) with data.benchmark_data_adapter as data_adapter
	test.assert_fail(finding) with input as rule_input_with_external("", create_process_config(true)) with data.benchmark_data_adapter as data_adapter
}

test_pass {
	test.assert_pass(finding) with input as rule_input("--anonymous-auth=false") with data.benchmark_data_adapter as data_adapter
	test.assert_pass(finding) with input as rule_input_with_external("--anonymous-auth=false", create_process_config(true)) with data.benchmark_data_adapter as data_adapter
	test.assert_pass(finding) with input as rule_input_with_external("--anonymous-auth=false", create_process_config(false)) with data.benchmark_data_adapter as data_adapter
	test.assert_pass(finding) with input as rule_input_with_external("", create_process_config(false)) with data.benchmark_data_adapter as data_adapter
}

test_not_evaluated {
	not finding with input as test_data.process_input("some_process", []) with data.benchmark_data_adapter as data_adapter
}

rule_input(argument) = test_data.process_input_with_external_data("kubelet", [argument], {})

rule_input_with_external(argument, external_data) = test_data.process_input_with_external_data("kubelet", [argument], external_data)

create_process_config(anonymous_enabled) = {"config": {"authentication": {
	"x509": {"clientCAFile": "/etc/kubernetes/pki/ca.crt"},
	"anonymous": {"enabled": anonymous_enabled},
	"webhook": {
		"cacheTTL": "0s",
		"enabled": true,
	},
}}}
