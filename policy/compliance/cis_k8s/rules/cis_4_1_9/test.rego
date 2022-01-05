package compliance.cis_k8s.rules.cis_4_1_9

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("config.yaml", "0700")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("config.yaml", "0644")
}

test_not_evaluated {
	not finding with input as rule_input("file.txt", "0644")
}

rule_input(filename, filemode) = filesystem_input {
	uid := "root"
	gid := "root"
	filesystem_input = test_data.filesystem_input(filename, filemode, uid, gid)
}
