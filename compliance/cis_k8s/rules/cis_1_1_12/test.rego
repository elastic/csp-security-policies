package compliance.cis_k8s.rules.cis_1_1_12

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("var/lib/etcd/", "root", "root")
	test.assert_fail(finding) with input as rule_input("var/lib/etcd/", "etcd", "root")
	test.assert_fail(finding) with input as rule_input("var/lib/etcd/", "root", "etcd")
	test.assert_fail(finding) with input as rule_input("var/lib/etcd/some_file.txt", "root", "etcd")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("var/lib/etcd/", "etcd", "etcd")
	test.assert_pass(finding) with input as rule_input("var/lib/etcd/some_file.txt", "etcd", "etcd")
}

test_not_evaluated {
	not finding with input as rule_input("file.txt", "root", "root")
}

rule_input(filename, uid, gid) = filesystem_input {
	filemode := "0644"
	filesystem_input = test_data.filesystem_input(filename, filemode, uid, gid)
}
