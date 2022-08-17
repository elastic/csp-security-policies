package compliance.cis_eks.rules.cis_3_2_10

import data.compliance.cis_eks.data_adapter
import data.kubernetes_common.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("--rotate-certificates false") with data.benchmark_data_adapter as data_adapter
	test.assert_fail(finding) with input as rule_input_with_external("", create_process_config(false)) with data.benchmark_data_adapter as data_adapter
	test.assert_fail(finding) with input as rule_input_with_external("--rotate-certificates false", create_process_config(true)) with data.benchmark_data_adapter as data_adapter
}

test_pass {
	test.assert_pass(finding) with input as rule_input("") with data.benchmark_data_adapter as data_adapter
	test.assert_pass(finding) with input as rule_input("--rotate-certificates true") with data.benchmark_data_adapter as data_adapter
	test.assert_pass(finding) with input as rule_input_with_external("--rotate-certificates true", create_process_config(false)) with data.benchmark_data_adapter as data_adapter
	test.assert_pass(finding) with input as rule_input_with_external("--rotate-certificates true", create_process_config(true)) with data.benchmark_data_adapter as data_adapter
	test.assert_pass(finding) with input as rule_input_with_external("", create_process_config(true)) with data.benchmark_data_adapter as data_adapter
}

test_not_evaluated {
	not finding with input as test_data.process_input("some_process", []) with data.benchmark_data_adapter as data_adapter
}

rule_input(argument) = test_data.process_input("kubelet", [argument])

rule_input_with_external(argument, external_data) = test_data.process_input_with_external_data("kubelet", [argument], external_data)

create_process_config(rotateCertificates) = {"config": {"rotateCertificates": rotateCertificates}}
