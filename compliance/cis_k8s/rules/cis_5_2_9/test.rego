package compliance.cis_k8s.rules.cis_5_2_9

import data.kubernetes_common.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input(violating_psp)
}

test_pass {
	test.assert_pass(finding) with input as rule_input(non_violating_psp)
	test.assert_pass(finding) with input as rule_input(non_violating_psp2)
}

test_not_evaluated {
	not finding with input as test_data.not_evaluated_input
	not finding with input as test_data.not_evaluated_kube_api_input
}

rule_input(resource) = test_data.kube_api_input(resource)

violating_psp = {
	"kind": "Pod",
	"uid": "00000aa0-0aa0-00aa-00aa-00aa000a0000",
	"spec": {"containers": [{"securityContext": {"capabilities": ["NET_RAW"]}}]},
}

non_violating_psp = {
	"kind": "Pod",
	"uid": "00000aa0-0aa0-00aa-00aa-00aa000a0000",
	"spec": {"containers": [{"securityContext": {}}]},
}

non_violating_psp2 = {
	"kind": "Pod",
	"uid": "00000aa0-0aa0-00aa-00aa-00aa000a0000",
	"spec": {"containers": [{"securityContext": {"capabilities": []}}]},
}
