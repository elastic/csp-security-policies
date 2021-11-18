package compliance.cis_k8s.rules.cis_1_1_12

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_violation(finding) with input as rule_input("root", "root")
	test.assert_violation(finding) with input as rule_input("etcd", "root")
	test.assert_violation(finding) with input as rule_input("root", "etcd")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("etcd", "etcd")
}

rule_input(uid, gid) = filesystem_input {
	filename := "etcd"
	filemode := "0700"
	filesystem_input = test_data.filesystem_input(filename, filemode, uid, gid)
}
