package compliance.aws_data_adatper

is_aws_eks_type {
	input.type == "aws-eks"
}

is_aws_elb_type {
	input.type == "aws-elb"
}

is_aws_ecr_pod_type {
	input.type == "aws-ecr"
	input.resource.kind == "Pod"
}
