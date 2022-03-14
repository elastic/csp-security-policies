package compliance.cis_k8s.rules.cis_5_1_3

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("ClusterRole", ["*"], [""], [""])
	test.assert_fail(finding) with input as rule_input("ClusterRole", [""], ["*"], [""])
	test.assert_fail(finding) with input as rule_input("ClusterRole", [""], [""], ["*"])
	test.assert_fail(finding) with input as rule_input("ClusterRole", ["*"], ["*"], [""])
	test.assert_fail(finding) with input as rule_input("ClusterRole", [""], ["*"], ["*"])
	test.assert_fail(finding) with input as rule_input("ClusterRole", ["*"], [""], ["*"])
	test.assert_fail(finding) with input as rule_input("Role", ["*"], [""], [""])
	test.assert_fail(finding) with input as rule_input("Role", [""], ["*"], [""])
	test.assert_fail(finding) with input as rule_input("Role", [""], [""], ["*"])
	test.assert_fail(finding) with input as rule_input("Role", ["*"], ["*"], [""])
	test.assert_fail(finding) with input as rule_input("Role", [""], ["*"], ["*"])
	test.assert_fail(finding) with input as rule_input("Role", ["*"], [""], ["*"])
	test.assert_fail(finding) with input as rule_input("Role", [""], [""], ["create", "*"])
}

test_pass {
	test.assert_pass(finding) with input as rule_input("ClusterRole", [""], [""], [""])
	test.assert_pass(finding) with input as rule_input("ClusterRole", ["create"], [""], [""])
	test.assert_pass(finding) with input as rule_input("ClusterRole", [""], ["create"], [""])
	test.assert_pass(finding) with input as rule_input("ClusterRole", [""], [""], ["create"])
	test.assert_pass(finding) with input as rule_input("Role", [""], [""], [""])
	test.assert_pass(finding) with input as rule_input("Role", ["create"], [""], [""])
	test.assert_pass(finding) with input as rule_input("Role", [""], ["create"], [""])
	test.assert_pass(finding) with input as rule_input("Role", [""], [""], ["create"])
	test.assert_pass(finding) with input as rule_input("Role", [""], [""], ["create", ""])
}

test_not_evaluated {
	not finding with input as {"type": "input", "resource": {"kind": "not_pod"}}
}

rule_input(kind, api_group, resource, verb) = test_data.kube_api_role_input(kind, api_group, resource, verb)
