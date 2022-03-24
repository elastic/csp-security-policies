package compliance.cis_k8s.rules.cis_5_1_3

import data.kubernetes_common.test_data
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
	not finding with input as test_data.not_evaluated_input
	not finding with input as test_data.not_evaluated_kube_api_input
}

rule_input(kind, api_group, resource, verb) = test_data.kube_api_role_input(kind, api_group, resource, verb)
