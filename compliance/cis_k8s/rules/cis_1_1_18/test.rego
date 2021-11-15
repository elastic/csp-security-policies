package compliance.cis.rules.cis_1_1_18

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.rule_violation(finding) with input as rule_input("root", "user")
	test.rule_violation(finding) with input as rule_input("user", "root")
	test.rule_violation(finding) with input as rule_input("user", "user")
}

test_pass {
	test.rule_pass(finding) with input as rule_input("root", "root")
}

rule_input(uid, gid) = filesystem_input {
	filename := "controller-manager.conf"
	filemode := "0644"
	filesystem_input = test_data.filesystem_input(filename, filemode, uid, gid)
}
