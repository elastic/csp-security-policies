package compliance.policy.aws_eks.ensure_private_access

import data.compliance.lib.common
import data.compliance.policy.aws_eks.data_adapter

#default rule_evaluation = false

# Allow only private access to cluster.
is_only_private(cluster) {
	cluster.ResourcesVpcConfig.EndpointPrivateAccess
	not cluster.ResourcesVpcConfig.EndpointPublicAccess
} else = false {
	true
}

# Ensure there Kuberenetes endpoint private access is enabled
finding = result {
	# filter
	data_adapter.is_aws_eks
	print(data_adapter.cluster)
	rule_evaluation := is_only_private(data_adapter.cluster)
	print(rule_evaluation)

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(rule_evaluation),
		{
			"endpoint_public_access": input.resource.Cluster.ResourcesVpcConfig.EndpointPublicAccess,
			"endpoint_private_access": input.resource.Cluster.ResourcesVpcConfig.EndpointPrivateAccess,
		},
	)
}
