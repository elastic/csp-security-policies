package compliance.cis_eks.data_adapter

import data.compliance.lib.data_adapter

is_aws_eks {
	input.type == "aws-container-management"
}

is_aws_elb {
	input.type == "aws-load-balancer"
}

is_aws_ecr {
	input.type == "aws-image-registry"
}

process_args = result {
	result = data_adapter.process_args(" ")
}
