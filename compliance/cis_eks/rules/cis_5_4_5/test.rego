package compliance.cis_eks.rules.cis_5_4_5

import data.cis_eks.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as violating_input_use_tcp_instead_of_https
	test.assert_fail(finding) with input as violating_input_use_both_https_and_tcp
	test.assert_fail(finding) with input as violating_input_use_https_only_but_no_certificate
}

test_pass {
	test.assert_pass(finding) with input as valid_input_use_https_only_with_certificate
	test.assert_pass(finding) with input as valid_input_with_two_https_listeners
}

test_not_evaluated {
	not finding with input as test_data.not_evaluated_input
}

violating_input_use_tcp_instead_of_https := {
	"type": "aws-elb",
	"resource": {"LoadBalancersDescription": [{
		"AvailabilityZones": [
			"us-east-2b",
			"us-east-2a",
		],
		"BackendServerDescriptions": null,
		"CanonicalHostedZoneName": "adda9cdc89b13452e92d48be46858d37-1423035038.us-east-2.elb.amazonaws.com",
		"CanonicalHostedZoneNameID": "Z3AADJGX6KTTL2",
		"CreatedTime": "2021-12-06T15:42:09.55Z",
		"DNSName": "adda9cdc89b13452e92d48be46858d37-1423035038.us-east-2.elb.amazonaws.com",
		"HealthCheck": {
			"HealthyThreshold": 2,
			"Interval": 10,
			"Target": "TCP:31829",
			"Timeout": 5,
			"UnhealthyThreshold": 6,
		},
		"Instances": [
			{"InstanceId": "i-0b81bd277b144e5e9"},
			{"InstanceId": "i-00e02dbffa8e2c54b"},
		],
		"ListenerDescriptions": [
			{
				"Listener": {
					"InstancePort": 32177,
					"InstanceProtocol": "TCP",
					"LoadBalancerPort": 443,
					"Protocol": "TCP",
					"SSLCertificateId": "dsaddsadda",
				},
				"PolicyNames": null,
			},
			{
				"Listener": {
					"InstancePort": 31829,
					"InstanceProtocol": "TCP",
					"LoadBalancerPort": 80,
					"Protocol": "TCP",
					"SSLCertificateId": null,
				},
				"PolicyNames": null,
			},
		],
		"LoadBalancerName": "adda9cdc89b13452e92d48be46858d37",
		"Policies": {
			"AppCookieStickinessPolicies": null,
			"LBCookieStickinessPolicies": null,
			"OtherPolicies": null,
		},
		"Scheme": "internet-facing",
		"SecurityGroups": ["sg-08357d8bd7b80fc4c"],
		"SourceSecurityGroup": {
			"GroupName": "k8s-elb-adda9cdc89b13452e92d48be46858d37",
			"OwnerAlias": "704479110758",
		},
		"Subnets": [
			"subnet-09021fed467f7ad25",
			"subnet-09b8d7fdb5776ab47",
		],
		"VPCId": "vpc-09b1bd8bbf4508a52",
	}]},
}

violating_input_use_both_https_and_tcp := {
	"type": "aws-elb",
	"resource": {"LoadBalancersDescription": [{
		"AvailabilityZones": [
			"us-east-2b",
			"us-east-2a",
		],
		"BackendServerDescriptions": null,
		"CanonicalHostedZoneName": "adda9cdc89b13452e92d48be46858d37-1423035038.us-east-2.elb.amazonaws.com",
		"CanonicalHostedZoneNameID": "Z3AADJGX6KTTL2",
		"CreatedTime": "2021-12-06T15:42:09.55Z",
		"DNSName": "adda9cdc89b13452e92d48be46858d37-1423035038.us-east-2.elb.amazonaws.com",
		"HealthCheck": {
			"HealthyThreshold": 2,
			"Interval": 10,
			"Target": "TCP:31829",
			"Timeout": 5,
			"UnhealthyThreshold": 6,
		},
		"Instances": [
			{"InstanceId": "i-0b81bd277b144e5e9"},
			{"InstanceId": "i-00e02dbffa8e2c54b"},
		],
		"ListenerDescriptions": [
			{
				"Listener": {
					"InstancePort": 32177,
					"InstanceProtocol": "TCP",
					"LoadBalancerPort": 443,
					"Protocol": "TCP",
					"SSLCertificateId": null,
				},
				"PolicyNames": null,
			},
			{
				"Listener": {
					"InstancePort": 443,
					"InstanceProtocol": "HTTPS",
					"LoadBalancerPort": 80,
					"Protocol": "TCP",
					"SSLCertificateId": "someId",
				},
				"PolicyNames": null,
			},
		],
		"LoadBalancerName": "adda9cdc89b13452e92d48be46858d37",
		"Policies": {
			"AppCookieStickinessPolicies": null,
			"LBCookieStickinessPolicies": null,
			"OtherPolicies": null,
		},
		"Scheme": "internet-facing",
		"SecurityGroups": ["sg-08357d8bd7b80fc4c"],
		"SourceSecurityGroup": {
			"GroupName": "k8s-elb-adda9cdc89b13452e92d48be46858d37",
			"OwnerAlias": "704479110758",
		},
		"Subnets": [
			"subnet-09021fed467f7ad25",
			"subnet-09b8d7fdb5776ab47",
		],
		"VPCId": "vpc-09b1bd8bbf4508a52",
	}]},
}

violating_input_use_https_only_but_no_certificate := {
	"type": "aws-elb",
	"resource": {"LoadBalancersDescription": [{
		"AvailabilityZones": [
			"us-east-2b",
			"us-east-2a",
		],
		"BackendServerDescriptions": null,
		"CanonicalHostedZoneName": "adda9cdc89b13452e92d48be46858d37-1423035038.us-east-2.elb.amazonaws.com",
		"CanonicalHostedZoneNameID": "Z3AADJGX6KTTL2",
		"CreatedTime": "2021-12-06T15:42:09.55Z",
		"DNSName": "adda9cdc89b13452e92d48be46858d37-1423035038.us-east-2.elb.amazonaws.com",
		"HealthCheck": {
			"HealthyThreshold": 2,
			"Interval": 10,
			"Target": "TCP:31829",
			"Timeout": 5,
			"UnhealthyThreshold": 6,
		},
		"Instances": [
			{"InstanceId": "i-0b81bd277b144e5e9"},
			{"InstanceId": "i-00e02dbffa8e2c54b"},
		],
		"ListenerDescriptions": [{
			"Listener": {
				"InstancePort": 32177,
				"InstanceProtocol": "HTTPS",
				"LoadBalancerPort": 443,
				"Protocol": "HTTPS",
				"SSLCertificateId": null,
			},
			"PolicyNames": null,
		}],
		"LoadBalancerName": "adda9cdc89b13452e92d48be46858d37",
		"Policies": {
			"AppCookieStickinessPolicies": null,
			"LBCookieStickinessPolicies": null,
			"OtherPolicies": null,
		},
		"Scheme": "internet-facing",
		"SecurityGroups": ["sg-08357d8bd7b80fc4c"],
		"SourceSecurityGroup": {
			"GroupName": "k8s-elb-adda9cdc89b13452e92d48be46858d37",
			"OwnerAlias": "704479110758",
		},
		"Subnets": [
			"subnet-09021fed467f7ad25",
			"subnet-09b8d7fdb5776ab47",
		],
		"VPCId": "vpc-09b1bd8bbf4508a52",
	}]},
}

valid_input_use_https_only_with_certificate := {
	"type": "aws-elb",
	"resource": {"LoadBalancersDescription": [{
		"AvailabilityZones": [
			"us-east-2b",
			"us-east-2a",
		],
		"BackendServerDescriptions": null,
		"CanonicalHostedZoneName": "adda9cdc89b13452e92d48be46858d37-1423035038.us-east-2.elb.amazonaws.com",
		"CanonicalHostedZoneNameID": "Z3AADJGX6KTTL2",
		"CreatedTime": "2021-12-06T15:42:09.55Z",
		"DNSName": "adda9cdc89b13452e92d48be46858d37-1423035038.us-east-2.elb.amazonaws.com",
		"HealthCheck": {
			"HealthyThreshold": 2,
			"Interval": 10,
			"Target": "TCP:31829",
			"Timeout": 5,
			"UnhealthyThreshold": 6,
		},
		"Instances": [
			{"InstanceId": "i-0b81bd277b144e5e9"},
			{"InstanceId": "i-00e02dbffa8e2c54b"},
		],
		"ListenerDescriptions": [{
			"Listener": {
				"InstancePort": 443,
				"InstanceProtocol": "HTTPS",
				"LoadBalancerPort": 80,
				"Protocol": "TCP",
				"SSLCertificateId": "someId",
			},
			"PolicyNames": null,
		}],
		"LoadBalancerName": "adda9cdc89b13452e92d48be46858d37",
		"Policies": {
			"AppCookieStickinessPolicies": null,
			"LBCookieStickinessPolicies": null,
			"OtherPolicies": null,
		},
		"Scheme": "internet-facing",
		"SecurityGroups": ["sg-08357d8bd7b80fc4c"],
		"SourceSecurityGroup": {
			"GroupName": "k8s-elb-adda9cdc89b13452e92d48be46858d37",
			"OwnerAlias": "704479110758",
		},
		"Subnets": [
			"subnet-09021fed467f7ad25",
			"subnet-09b8d7fdb5776ab47",
		],
		"VPCId": "vpc-09b1bd8bbf4508a52",
	}]},
}

valid_input_with_two_https_listeners := {
	"type": "aws-elb",
	"resource": {"LoadBalancersDescription": [{
		"AvailabilityZones": [
			"us-east-2b",
			"us-east-2a",
		],
		"BackendServerDescriptions": null,
		"CanonicalHostedZoneName": "adda9cdc89b13452e92d48be46858d37-1423035038.us-east-2.elb.amazonaws.com",
		"CanonicalHostedZoneNameID": "Z3AADJGX6KTTL2",
		"CreatedTime": "2021-12-06T15:42:09.55Z",
		"DNSName": "adda9cdc89b13452e92d48be46858d37-1423035038.us-east-2.elb.amazonaws.com",
		"HealthCheck": {
			"HealthyThreshold": 2,
			"Interval": 10,
			"Target": "TCP:31829",
			"Timeout": 5,
			"UnhealthyThreshold": 6,
		},
		"Instances": [
			{"InstanceId": "i-0b81bd277b144e5e9"},
			{"InstanceId": "i-00e02dbffa8e2c54b"},
		],
		"ListenerDescriptions": [
			{
				"Listener": {
					"InstancePort": 443,
					"InstanceProtocol": "HTTPS",
					"LoadBalancerPort": 80,
					"Protocol": "HTTPS",
					"SSLCertificateId": "someId",
				},
				"PolicyNames": null,
			},
			{
				"Listener": {
					"InstancePort": 443,
					"InstanceProtocol": "HTTPS",
					"LoadBalancerPort": 80,
					"Protocol": "HTTPS",
					"SSLCertificateId": "someOtherId",
				},
				"PolicyNames": null,
			},
		],
		"LoadBalancerName": "adda9cdc89b13452e92d48be46858d37",
		"Policies": {
			"AppCookieStickinessPolicies": null,
			"LBCookieStickinessPolicies": null,
			"OtherPolicies": null,
		},
		"Scheme": "internet-facing",
		"SecurityGroups": ["sg-08357d8bd7b80fc4c"],
		"SourceSecurityGroup": {
			"GroupName": "k8s-elb-adda9cdc89b13452e92d48be46858d37",
			"OwnerAlias": "704479110758",
		},
		"Subnets": [
			"subnet-09021fed467f7ad25",
			"subnet-09b8d7fdb5776ab47",
		],
		"VPCId": "vpc-09b1bd8bbf4508a52",
	}]},
}
