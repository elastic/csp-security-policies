package compliance.cis_k8s.rules.cis_1_1_6

import data.kubernetes_common.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("kube-scheduler.yaml", "root", "owner")
	test.assert_fail(finding) with input as rule_input("kube-scheduler.yaml", "owner", "root")
	test.assert_fail(finding) with input as rule_input("kube-scheduler.yaml", "owner", "owner")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("kube-scheduler.yaml", "root", "root")
}

test_not_evaluated {
	not finding with input as rule_input("file.txt", "root", "root")
}

rule_input(filename, user, group) = filesystem_input {
	filemode := "0644"
	filesystem_input = test_data.filesystem_input(filename, filemode, user, group)
}
