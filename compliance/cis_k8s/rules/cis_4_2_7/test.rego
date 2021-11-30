package compliance.cis_k8s.rules.cis_4_2_7

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("kublet", "--make-iptables-util-chains=false")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("kublet", "")
	test.assert_pass(finding) with input as rule_input("kublet", "--make-iptables-util-chains=true")
}

test_not_evaluated {
	not finding with input as rule_input("some_process", "")
}

rule_input(process_type, argument) = test_data.kublet_input(process_type, [argument])
