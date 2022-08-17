package compliance.cis_k8s.rules.cis_1_2_13

import data.compliance.cis_k8s.data_adapter
import data.kubernetes_common.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("") with data.benchmark_data_adapter as data_adapter
	test.assert_fail(finding) with input as rule_input("--enable-admission-plugins=AlwaysDeny") with data.benchmark_data_adapter as data_adapter
}

test_pass {
	test.assert_pass(finding) with input as rule_input("--enable-admission-plugins=SecurityContextDeny,PodSecurityPolicy") with data.benchmark_data_adapter as data_adapter
	test.assert_pass(finding) with input as rule_input("--enable-admission-plugins=SecurityContextDeny") with data.benchmark_data_adapter as data_adapter
	test.assert_pass(finding) with input as rule_input("--enable-admission-plugins=AlwaysDeny,SecurityContextDeny") with data.benchmark_data_adapter as data_adapter
	test.assert_pass(finding) with input as rule_input("--enable-admission-plugins=PodSecurityPolicy") with data.benchmark_data_adapter as data_adapter
}

test_not_evaluated {
	not finding with input as test_data.process_input("some_process", []) with data.benchmark_data_adapter as data_adapter
}

rule_input(argument) = test_data.process_input("kube-apiserver", [argument])
