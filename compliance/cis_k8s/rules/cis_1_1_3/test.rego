package compliance.cis_k8s.rules.cis_1_1_3

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.rule_violation(finding) with input as rule_input("0700")
}

test_pass {
	test.rule_pass(finding) with input as rule_input("0644")
}

rule_input(filemode) = filesystem_input {
	filename := "kube-controller-manager.yaml"
	uid := "root"
	gid := "root"
	filesystem_input = test_data.filesystem_input(filename, filemode, uid, gid)
}
