package compliance.cis_k8s.rules.cis_5_2_5

import data.cis_k8s.test_data
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
	not finding with input as rule_input({"kind": "not_pod"})
}

rule_input(resource) = test_data.kube_api_input(resource)

violating_psp = {
	"kind": "Pod",
	"spec": {"containers": [{"securityContext": {"allowPrivilegeEscalation": true}}]},
}

violating_psp2 = {
	"kind": "Pod",
	"spec": {"containers": [
		{"securityContext": {"allowPrivilegeEscalation": true}},
		{"securityContext": {"allowPrivilegeEscalation": false}},
	]},
}

violating_psp3 = {
	"kind": "Pod",
	"spec": {"containers": [
		{"securityContext": {"allowPrivilegeEscalation": true}},
		{"securityContext": {}},
	]},
}

violating_psp4 = {
	"kind": "Pod",
	"spec": {"containers": [
		{"securityContext": {"allowPrivilegeEscalation": true}},
		{"securityContext": {}},
		{},
	]},
}

non_violating_psp = {
	"kind": "Pod",
	"spec": {"containers": [{"securityContext": {"allowPrivilegeEscalation": false}}]},
}

non_violating_psp2 = {
	"kind": "Pod",
	"spec": {"containers": [{"securityContext": {}}]},
}
