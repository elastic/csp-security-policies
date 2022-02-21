package compliance.cis_eks.rules.cis_5_1_1

import data.cis_eks.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as violating_input_scan_on_push_disabled
	test.assert_fail(finding) with input as violating_input_scan_on_push_disabled_in_one_repo
}

test_pass {
	test.assert_pass(finding) with input as valid_input
}

test_not_evaluated {
	not finding with input as not_evaluated_input
}

violating_input_scan_on_push_disabled = {
	"type": "aws-ecr",
	"resource": {"EcrRepositories": [{
		"kind": "Pod",
		"CreatedAt": "2020-07-29T11:44:18Z",
		"ImageScanningConfiguration": {"ScanOnPush": false},
		"ImageTagMutability": "MUTABLE",
		"RegistryId": "704479110758",
		"RepositoryArn": "arn:aws:ecr:us-east-2:704479110758:repository/build.security.management",
		"RepositoryName": "build.security.management",
		"RepositoryUri": "704479110758.dkr.ecr.us-east-2.amazonaws.com/build.security.management",
	}]},
}

violating_input_scan_on_push_disabled_in_one_repo = {
	"type": "aws-ecr",
	"resource": {"EcrRepositories": [
		{
			"kind": "Pod",
			"CreatedAt": "2020-07-29T11:44:18Z",
			"ImageScanningConfiguration": {"ScanOnPush": false},
			"ImageTagMutability": "MUTABLE",
			"RegistryId": "704479110758",
			"RepositoryArn": "arn:aws:ecr:us-east-2:704479110758:repository/build.security.management",
			"RepositoryName": "build.security.management",
			"RepositoryUri": "704479110758.dkr.ecr.us-east-2.amazonaws.com/build.security.management",
		},
		{
			"kind": "Pod",
			"CreatedAt": "2020-07-29T11:44:18Z",
			"ImageScanningConfiguration": {"ScanOnPush": true},
			"ImageTagMutability": "MUTABLE",
			"RegistryId": "704479110758",
			"RepositoryArn": "arn:aws:ecr:us-east-2:704479110758:repository/build.security.management",
			"RepositoryName": "build.security.management2",
			"RepositoryUri": "704479110758.dkr.ecr.us-east-2.amazonaws.com/build.security.management",
		},
	]},
}

valid_input = {
	"type": "aws-ecr",
	"resource": {"EcrRepositories": [{
		"kind": "Pod",
		"CreatedAt": "2020-07-29T11:44:18Z",
		"ImageScanningConfiguration": {"ScanOnPush": true},
		"ImageTagMutability": "MUTABLE",
		"RegistryId": "704479110758",
		"RepositoryArn": "arn:aws:ecr:us-east-2:704479110758:repository/build.security.management",
		"RepositoryName": "build.security.management",
		"RepositoryUri": "704479110758.dkr.ecr.us-east-2.amazonaws.com/build.security.management",
	}]},
}

not_evaluated_input = {
	"type": "some-type",
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
		"Name": "EKS-Elastic-agent-demo",
	}},
}
