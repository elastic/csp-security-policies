package compliance.cis_k8s.rules.cis_5_2_5

import data.kubernetes_common.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input(violating_psp)
	test.assert_fail(finding) with input as rule_input(violating_psp2)
	test.assert_fail(finding) with input as rule_input(violating_psp3)
	test.assert_fail(finding) with input as rule_input(violating_psp4)
}

test_pass {
	test.assert_pass(finding) with input as rule_input(non_violating_psp)
	test.assert_pass(finding) with input as rule_input(non_violating_psp2)
}

test_not_evaluated {
	not finding with input as {"type": "no-kube-api"}
}

rule_input(resource) = test_data.kube_api_input(resource)

violating_psp = {
	"kind": "Pod",
	"uid": "00000aa0-0aa0-00aa-00aa-00aa000a0000",
	"spec": {"containers": [{"name": "container_1", "securityContext": {"allowPrivilegeEscalation": true}}]},
}

violating_psp2 = {
	"kind": "Pod",
	"uid": "00000aa0-0aa0-00aa-00aa-00aa000a0000",
	"spec": {"containers": [
		{"name": "container_1", "securityContext": {"allowPrivilegeEscalation": true}},
		{"name": "container_2", "securityContext": {"allowPrivilegeEscalation": false}},
	]},
}

violating_psp3 = {
	"kind": "Pod",
	"uid": "00000aa0-0aa0-00aa-00aa-00aa000a0000",
	"spec": {"containers": [
		{"name": "container_1", "securityContext": {"allowPrivilegeEscalation": true}},
		{"name": "container_2", "securityContext": {}},
	]},
}

violating_psp4 = {
	"kind": "Pod",
	"uid": "00000aa0-0aa0-00aa-00aa-00aa000a0000",
	"spec": {"containers": [
		{"name": "container_1", "securityContext": {"allowPrivilegeEscalation": true}},
		{"name": "container_2", "securityContext": {}},
		{"name": "container_3"},
	]},
}

non_violating_psp = {
	"kind": "Pod",
	"uid": "00000aa0-0aa0-00aa-00aa-00aa000a0000",
	"spec": {"containers": [{"name": "container_1", "securityContext": {"allowPrivilegeEscalation": false}}]},
}

non_violating_psp2 = {
	"kind": "Pod",
	"uid": "00000aa0-0aa0-00aa-00aa-00aa000a0000",
	"spec": {"containers": [{"name": "container_1", "securityContext": {}}]},
}
