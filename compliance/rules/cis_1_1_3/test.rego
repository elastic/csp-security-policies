package compliance.cis.rules.cis_1_1_3

import data.lib.test

test_violation {
	test.rule_violation(finding) with input as rule_input("0700")
}

test_pass {
	test.rule_pass(finding) with input as rule_input("0644")
}

rule_input(filemode) = {"osquery": {
	"mode": filemode,
	"path": "/etc/kubernetes/manifests/kube-controller-manager.yaml",
	"uid": "root",
	"filename": "kube-controller-manager.yaml",
	"gid": "root",
}}
