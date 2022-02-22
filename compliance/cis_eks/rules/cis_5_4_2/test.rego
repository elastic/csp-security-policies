package compliance.cis_eks.rules.cis_5_4_2

import data.cis_eks.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as violating_input_private_access_disabled
	test.assert_fail(finding) with input as violating_input_public_invalid_filter
	test.assert_fail(finding) with input as violating_input_private_access_enabled_and_public_access_enabled_but_an_unvalid_filter
}

test_pass {
	test.assert_pass(finding) with input as non_violating_input
	test.assert_pass(finding) with input as valid_input_public_access_disabled_and_private_endpoint_endabled
}

test_not_evaluated {
	not finding with input as test_data.not_evaluated_input
}

violating_input_private_access_disabled = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:somearn1234:cluster/EKS-demo",
		"CertificateAuthority": {"Data": "some data"},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBdDB096B80AA626B023SS520SS"}},
		"Logging": {"ClusterLogging": [{
			"Enabled": false,
			"Types": [
				"api",
				"audit",
				"authenticator",
				"controllerManager",
				"scheduler",
			],
		}]},
		"ResourcesVpcConfig": {
			"ClusterSecurityGroupId": "sg-00abc463e0e831064",
			"EndpointPrivateAccess": false,
			"EndpointPublicAccess": true,
			"PublicAccessCidrs": ["132.1.50.0/0"],
			"SecurityGroupIds": ["sg-01f510f46974d3b5c"],
			"SubnetIds": [
				"subnet-03917f8779ce37c47",
				"subnet-09b8d7fdb5776ab47",
				"subnet-09021fed467f7ad25",
				"subnet-0885421a2d53b91c7",
			],
			"VpcId": "vpc-09b1bd8bbf4508a52",
		},
		"Name": "EKS-Elastic-agent-demo",
	}},
}

valid_input_public_access_disabled_and_private_endpoint_endabled = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:somearn1234:cluster/EKS-demo",
		"CertificateAuthority": {"Data": "some data"},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBdDB096B80AA626B023SS520SS"}},
		"Logging": {"ClusterLogging": [{
			"Enabled": false,
			"Types": [
				"api",
				"audit",
				"authenticator",
				"controllerManager",
				"scheduler",
			],
		}]},
		"ResourcesVpcConfig": {
			"ClusterSecurityGroupId": "sg-00abc463e0e831064",
			"EndpointPrivateAccess": true,
			"EndpointPublicAccess": false,
			"PublicAccessCidrs": ["0.0.0.0/0"],
			"SecurityGroupIds": ["sg-01f510f46974d3b5c"],
			"SubnetIds": [
				"subnet-03917f8779ce37c47",
				"subnet-09b8d7fdb5776ab47",
				"subnet-09021fed467f7ad25",
				"subnet-0885421a2d53b91c7",
			],
			"VpcId": "vpc-09b1bd8bbf4508a52",
		},
		"Name": "EKS-Elastic-agent-demo",
	}},
}

violating_input_public_invalid_filter = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:somearn1234:cluster/EKS-demo",
		"CertificateAuthority": {"Data": "some data"},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBdDB096B80AA626B023SS520SS"}},
		"Logging": {"ClusterLogging": [{
			"Enabled": false,
			"Types": [
				"api",
				"audit",
				"authenticator",
				"controllerManager",
				"scheduler",
			],
		}]},
		"ResourcesVpcConfig": {
			"ClusterSecurityGroupId": "sg-00abc463e0e831064",
			"EndpointPrivateAccess": true,
			"EndpointPublicAccess": true,
			"PublicAccessCidrs": ["0.0.0.0/0"],
			"SecurityGroupIds": ["sg-01f510f46974d3b5c"],
			"SubnetIds": [
				"subnet-03917f8779ce37c47",
				"subnet-09b8d7fdb5776ab47",
				"subnet-09021fed467f7ad25",
				"subnet-0885421a2d53b91c7",
			],
			"VpcId": "vpc-09b1bd8bbf4508a52",
		},
		"Name": "EKS-Elastic-agent-demo",
	}},
}

violating_input_private_access_enabled_and_public_access_enabled_but_an_unvalid_filter = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:somearn1234:cluster/EKS-demo",
		"CertificateAuthority": {"Data": "some data"},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBdDB096B80AA626B023SS520SS"}},
		"Logging": {"ClusterLogging": [{
			"Enabled": false,
			"Types": [
				"api",
				"audit",
				"authenticator",
				"controllerManager",
				"scheduler",
			],
		}]},
		"ResourcesVpcConfig": {
			"ClusterSecurityGroupId": "sg-00abc463e0e831064",
			"EndpointPrivateAccess": true,
			"EndpointPublicAccess": true,
			"PublicAccessCidrs": ["0.0.0.0/0"],
			"SecurityGroupIds": ["sg-01f510f46974d3b5c"],
			"SubnetIds": [
				"subnet-03917f8779ce37c47",
				"subnet-09b8d7fdb5776ab47",
				"subnet-09021fed467f7ad25",
				"subnet-0885421a2d53b91c7",
			],
			"VpcId": "vpc-09b1bd8bbf4508a52",
		},
		"Name": "EKS-Elastic-agent-demo",
	}},
}

non_violating_input = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:somearn1234:cluster/EKS-demo",
		"CertificateAuthority": {"Data": "some data"},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": [{
			"Provider": {},
			"Resources": [],
		}],
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBdDB096B80AA626B023SS520SS"}},
		"Logging": {"ClusterLogging": [{
			"Enabled": true,
			"Types": [
				"api",
				"audit",
				"authenticator",
				"controllerManager",
				"scheduler",
			],
		}]},
		"ResourcesVpcConfig": {
			"ClusterSecurityGroupId": "sg-00abc463e0e831064",
			"EndpointPrivateAccess": true,
			"EndpointPublicAccess": true,
			"PublicAccessCidrs": ["203.0.113.5/32"],
			"SecurityGroupIds": ["sg-01f510f46974d3b5c"],
			"SubnetIds": [
				"subnet-03917f8779ce37c47",
				"subnet-09b8d7fdb5776ab47",
				"subnet-09021fed467f7ad25",
				"subnet-0885421a2d53b91c7",
			],
			"VpcId": "vpc-09b1bd8bbf4508a52",
		},
		"Name": "EKS-Elastic-agent-demo",
	}},
}
