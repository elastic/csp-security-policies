package compliance.cis_k8s.rules.cis_1_1_19

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("etc/kubernetes/pki", "root", "user")
	test.assert_fail(finding) with input as rule_input("etc/kubernetes/pki", "user", "root")
	test.assert_fail(finding) with input as rule_input("etc/kubernetes/pki", "user", "user")
	test.assert_fail(finding) with input as rule_input("etc/kubernetes/pki/some_file.txt", "root", "user")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("etc/kubernetes/pki", "root", "root")
	test.assert_pass(finding) with input as rule_input("etc/kubernetes/pki/some_file.txt", "root", "root")
}

test_not_evaluated {
	not finding with input as rule_input("file.txt", "root", "root")
	not finding with input as rule_input("etc/kubernetes/pkii", "root", "root")
	not finding with input as rule_input("etc/kubernetes/pkii/file.txt", "root", "root")
}

rule_input(filename, uid, gid) = filesystem_input {
	filemode := "0644"
	filesystem_input = test_data.filesystem_input(filename, filemode, uid, gid)
}
