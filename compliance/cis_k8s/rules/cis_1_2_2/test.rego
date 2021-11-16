package compliance.cis_k8s.rules.cis_1_2_2

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.rule_violation(finding) with input as rule_input("--basic-auth-file")
}

test_pass {
	test.rule_pass(finding) with input as rule_input("")
}

rule_input(argument) = test_data.api_server_input([argument])
