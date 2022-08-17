package compliance.cis_k8s.rules.cis_2_4

import data.compliance.cis_k8s.data_adapter
import data.kubernetes_common.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input([""]) with data.benchmark_data_adapter as data_adapter
	test.assert_fail(finding) with input as rule_input(["--peer-cert-file=</path/to/peer-cert-file>"]) with data.benchmark_data_adapter as data_adapter
	test.assert_fail(finding) with input as rule_input(["--peer-key-file=</path/to/peer-key-file>"]) with data.benchmark_data_adapter as data_adapter
}

test_pass {
	test.assert_pass(finding) with input as rule_input(["--peer-cert-file=</path/to/peer-cert-file>", "--peer-key-file=</path/to/peer-key-file>"]) with data.benchmark_data_adapter as data_adapter
}

test_not_evaluated {
	not finding with input as test_data.process_input("some_process", [""]) with data.benchmark_data_adapter as data_adapter
}

rule_input(argument) = test_data.process_input("etcd", argument)
