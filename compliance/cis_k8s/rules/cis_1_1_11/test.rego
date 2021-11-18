package compliance.cis_k8s.rules.cis_1_1_11

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_violation(finding) with input as rule_input("0710")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("0600")
}

rule_input(filemode) = filesystem_input {
	filename := "etcd"
	uid := "root"
	gid := "root"
	filesystem_input = test_data.filesystem_input(filename, filemode, uid, gid)
}
