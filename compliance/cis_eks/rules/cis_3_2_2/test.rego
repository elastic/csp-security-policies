package compliance.cis_eks.rules.cis_3_2_2

import data.kubernetes_common.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("")
	test.assert_fail(finding) with input as rule_input("--authorization-mode=AlwaysAllow")
	test.assert_fail(finding) with input as rule_input("--authorization-mode=RBAC,AlwaysAllow")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("--authorization-mode=RBAC")
}

test_not_evaluated {
	not finding with input as test_data.process_input("some_process", [])
}

rule_input(argument) = test_data.process_input("kubelet", [argument])