package compliance.policy.kube_api.minimize_certain_capability

import data.compliance.lib.common
import data.compliance.policy.kube_api.data_adapter

default rule_evaluation = false

rule_evaluation {
	print("resource: ", input.resource)
	print("operation: ", data_adapter.containers)
	container := data_adapter.containers.app_containers[_]
	print("container: ", container)
	common.array_contains(container.securityContext.capabilities.drop, "NET_RAW")
	print("result 1: ", common.array_contains(container.securityContext.capabilities.drop, "NET_RAW"))
}

# or
rule_evaluation {
	container := data_adapter.containers.app_containers[_]
	common.array_contains(container.securityContext.capabilities.drop, "ALL")
	print("result 2: ", common.array_contains(container.securityContext.capabilities.drop, "ALL"))
}

finding := result {
	data_adapter.is_kube_api

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(rule_evaluation),
		{"containers": {json.filter(c, ["name", "securityContext"]) | c := data_adapter.containers.app_containers[_]}},
	)
}
