package compliance.cis_k8s.rules.cis_5_2_1

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input(violating_pod)
	test.assert_fail(finding) with input as rule_input(violating_pod2)
	test.assert_fail(finding) with input as rule_input(violating_pod3)
	test.assert_fail(finding) with input as rule_input(violating_pod4)
}

test_pass {
	test.assert_pass(finding) with input as rule_input(non_violating_pod)
	test.assert_pass(finding) with input as rule_input(non_violating_pod2)
}

test_not_evaluated {
	not finding with input as rule_input({"kind": "not_pod"})
}

rule_input(resource) = test_data.kube_api_input(resource)

violating_pod = {
	"kind": "Pod",
	"spec": {"containers": [{"securityContext": {"privileged": true}}]},
}

violating_pod2 = {
	"kind": "Pod",
	"spec": {"containers": [
		{"securityContext": {"privileged": true}},
		{"securityContext": {"privileged": false}},
	]},
}

violating_pod3 = {
	"kind": "Pod",
	"spec": {"containers": [
		{"securityContext": {"privileged": true}},
		{"securityContext": {}},
	]},
}

violating_pod4 = {
	"kind": "Pod",
	"spec": {"containers": [
		{"securityContext": {"privileged": true}},
		{"securityContext": {}},
		{},
	]},
}

non_violating_pod = {
	"kind": "Pod",
	"spec": {"containers": [{"securityContext": {"privileged": false}}]},
}

non_violating_pod2 = {
	"kind": "Pod",
	"spec": {"containers": [{"securityContext": {}}]},
}
