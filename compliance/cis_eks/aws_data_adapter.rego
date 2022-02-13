package compliance.aws_data_adatper

is_aws_eks {
	input.type == "aws-eks"
}

is_aws_elb {
	input.type == "aws-elb"
}

is_aws_ecr_pod {
	input.type == "aws-ecr"
	input.resource.kind == "Pod"
}
