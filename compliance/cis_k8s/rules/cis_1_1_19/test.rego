package compliance.cis_k8s.rules.cis_1_1_19

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_violation(finding) with input as rule_input("root", "user")
	test.assert_violation(finding) with input as rule_input("user", "root")
	test.assert_violation(finding) with input as rule_input("user", "user")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("root", "root")
}

rule_input(uid, gid) = filesystem_input {
	filename := "pki"
	filemode := "0644"
	filesystem_input = test_data.filesystem_input(filename, filemode, uid, gid)
}