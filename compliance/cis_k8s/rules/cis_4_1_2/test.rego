package compliance.cis_k8s.rules.cis_4_1_2

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("10-kubeadm.conf", "root", "user")
	test.assert_fail(finding) with input as rule_input("10-kubeadm.conf", "user", "root")
	test.assert_fail(finding) with input as rule_input("10-kubeadm.conf", "user", "user")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("10-kubeadm.conf", "root", "root")
}

test_not_evaluated {
	not finding with input as rule_input("file.txt", "root", "root")
}

rule_input(filename, uid, gid) = filesystem_input {
	filemode := "0644"
	filesystem_input = test_data.filesystem_input(filename, filemode, uid, gid)
}