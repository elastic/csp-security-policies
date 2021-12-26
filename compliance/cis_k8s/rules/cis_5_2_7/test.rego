package compliance.cis_k8s.rules.cis_5_2_7

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input({"pods": [violating_pod]})
	test.assert_fail(finding) with input as rule_input({"pods": [violating_pod, violating_pod2]})
}

test_pass {
	test.assert_pass(finding) with input as rule_input({"pods": [non_violating_pod]})
	test.assert_pass(finding) with input as rule_input({"pods": [non_violating_pod2]})
	test.assert_pass(finding) with input as rule_input({"pods": [non_violating_pod, non_violating_pod2]})
	test.assert_pass(finding) with input as rule_input({"pods": [violating_pod, non_violating_pod]})
	test.assert_pass(finding) with input as rule_input({"pods": [violating_pod, non_violating_pod2]})
}

test_not_evaluated {
	not finding with input as test_data.process_input("some_process", [])
}

rule_input(resource) = test_data.kube_api_input(resource)

violating_pod = {
	"kind": "Pod",
	"metadata": {"uid": "1"},
	"spec": {"requiredDropCapabilities": ["KILL"]},
}

violating_pod2 = {
	"kind": "Pod",
	"metadata": {"uid": "2"},
	"spec": {"requiredDropCapabilities": ["KILL", "SETFCAP"]},
}

non_violating_pod = {
	"kind": "Pod",
	"metadata": {"uid": "3"},
	"spec": {"requiredDropCapabilities": ["ALL"]},
}

non_violating_pod2 = {
	"kind": "Pod",
	"metadata": {"uid": "3"},
	"spec": {"requiredDropCapabilities": ["NET_RAW"]},
}
