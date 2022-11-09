package compliance.cis_k8s.rules.cis_1_2_27

import data.compliance.cis_k8s.data_adapter
import data.kubernetes_common.test_data
import data.lib.test

test_violation {
	eval_fail with input as rule_input([""])
	eval_fail with input as rule_input(["--tls-cert-file=<path/to/tls-cert>"])
	eval_fail with input as rule_input(["--tls-private-key-file=<path/to/tls-key>"])
}

test_pass {
	eval_pass with input as rule_input(["--tls-private-key-file=<path/to/tls-key>", "--tls-cert-file=<path/to/tls-cert>"])
}

test_not_evaluated {
	not_eval with input as test_data.process_input("some_process", [""])
}

rule_input(argument) = test_data.process_input("kube-apiserver", argument)

eval_fail {
	test.assert_fail(finding) with data.benchmark_data_adapter as data_adapter
}

eval_pass {
	test.assert_pass(finding) with data.benchmark_data_adapter as data_adapter
}

not_eval {
	not finding with data.benchmark_data_adapter as data_adapter
}
