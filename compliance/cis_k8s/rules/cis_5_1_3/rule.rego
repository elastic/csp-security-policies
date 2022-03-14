package compliance.cis_k8s.rules.cis_5_1_3

import data.compliance.cis_k8s
import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.lib.data_adapter
import future.keywords.in

# Minimize wildcard use in Roles and ClusterRoles (Manual)

# evaluate
default rule_evaluation = false

rule_evaluation {
	api_groups := data_adapter.cluster_roles.rules[i].apiGroups
	resources := data_adapter.cluster_roles.rules[i].resources
	verbs := data_adapter.cluster_roles.rules[i].verbs

	assert.is_false("*" in api_groups) # assert no wild-cards in api_group
	assert.is_false("*" in resources) # assert no wild-cards in api_group
	assert.is_false("*" in verbs) # assert no wild-cards in api_group
}

finding = result {
	# filter
	data_adapter.is_kube_api

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"cluster_roles": data_adapter.cluster_roles},
	}
}

metadata = {
	"name": "Minimize wildcard use in Roles and ClusterRoles",
	"description": `Kubernetes Roles and ClusterRoles provide access to resources based on sets of objects and actions that can be taken on those objects.
It is possible to set either of these to be the wildcard "*" which matches all items.
Use of wildcards is not optimal from a security perspective as it may allow for inadvertent access to be granted when new resources are added to the Kubernetes API either as CRDs or in later versions of the product.`,
	"tags": array.concat(cis_k8s.default_tags, ["CIS 5.1.3", "RBAC and Service Accounts"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": "Where possible replace any use of wildcards in clusterroles and roles with specific objects or actions.",
	"rationale": `The principle of least privilege recommends that users are provided only the access required for their role and nothing more.
The use of wildcard rights grants is likely to provide excessive rights to the Kubernetes API.`,
	"impact": "None",
	"default_value": "",
}
