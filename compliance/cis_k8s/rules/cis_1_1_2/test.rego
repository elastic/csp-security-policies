package compliance.cis_k8s.rules.cis_1_1_2

import data.cis_k8s.test

test_violation {
	test.rule_violation(finding) with input as rule_input("root", "user")
	test.rule_violation(finding) with input as rule_input("user", "root")
	test.rule_violation(finding) with input as rule_input("user", "user")
}

test_pass {
	test.rule_pass(finding) with input as rule_input("root", "root")
}

rule_input(uid, gid) = filesystem_input {
	filename := "kube-apiserver.yaml"
	filemode := "0644"
	filesystem_input = test.generate_filesystem_input(filename, filemode, uid, gid)
}
