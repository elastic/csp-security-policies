package compliance.policy.aws_eks.data_adapter

is_aws_eks {
	input.subType == "aws-eks"
}

cluster = input.resource.Cluster

status = input.resource.status

is_kube_api {
	input.type == "k8s_object"
}

is_kube_node {
	is_kube_api
	input.resource.kind == "Node"
}
