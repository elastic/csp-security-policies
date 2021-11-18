package compliance.cis.rules.cis_1_1_18

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_violation(finding) with input as rule_input("controller-manager.conf", "root", "user")
	test.assert_violation(finding) with input as rule_input("controller-manager.conf", "user", "root")
	test.assert_violation(finding) with input as rule_input("controller-manager.conf", "user", "user")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("controller-manager.conf", "root", "root")
}

test_not_evaluated {
	not finding with input as rule_input("file.txt", "root", "root")
}

rule_input(filename, uid, gid) = filesystem_input {
	filemode := "0644"
	filesystem_input = test_data.filesystem_input(filename, filemode, uid, gid)
}
