package compliance.cis_k8s.rules.cis_1_2_17

import data.compliance.cis_k8s.data_adapter
import data.kubernetes_common.test_data
import data.lib.test

violations {
	test.assert_fail(finding) with input as rule_input("--secure-port=0")
}

test_violation {
	violations with data.benchmark_data_adapter as data_adapter
}

passes {
	test.assert_pass(finding) with input as rule_input("--secure-port=1")
	test.assert_pass(finding) with input as rule_input("--secure-port=65535")
	test.assert_pass(finding) with input as rule_input("")
}

test_pass {
	passes with data.benchmark_data_adapter as data_adapter
}

test_not_evaluated {
	not finding with input as test_data.process_input("some_process", []) with data.benchmark_data_adapter as data_adapter with data.benchmark_data_adapter as data_adapter
}

rule_input(argument) = test_data.process_input("kube-apiserver", [argument])
