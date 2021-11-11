package compliance.cis.rules.cis_1_1_17

import data.lib.test

test_violation {
	test.rule_violation(finding) with input as rule_input("0700")
}

test_pass {
	test.rule_pass(finding) with input as rule_input("0644")
}

rule_input(filemode) = {"osquery": {
	"mode": filemode,
	"path": "/etc/kubernetes/controller-manager.conf",
	"uid": "root",
	"filename": "controller-manager.conf",
	"gid": "root",
}}
