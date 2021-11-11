package compliance.cis.rules.cis_1_1_16

import data.lib.test

test_violation {
	test.rule_violation(finding) with input as rule_input("root", "user")
	test.rule_violation(finding) with input as rule_input("user", "root")
	test.rule_violation(finding) with input as rule_input("user", "user")
}

test_pass {
	test.rule_pass(finding) with input as rule_input("root", "root")
}

rule_input(uid, gid) = {"osquery": {
	"mode": "0644",
	"path": "/etc/kubernetes/scheduler.conf",
	"uid": uid,
	"filename": "scheduler.conf",
	"gid": gid,
}}
