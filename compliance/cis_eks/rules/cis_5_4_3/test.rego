package compliance.cis_eks.rules.cis_5_4_3

import data.cis_eks.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as violating_input_public_ip_and_public_address
}

test_pass {
	test.assert_pass(finding) with input as valid_input_no_external_IP
	test.assert_pass(finding) with input as valid_input_external_IP_set_to_local_host
}

test_not_evaluated {
	not finding with input as test_data.not_evaluated_input
}

violating_input_public_ip_and_public_address = {
	"type": "kube-api",
	"resource": {
		"kind": "Node",
		"status": {
			"capacity": {
				"attachable-volumes-aws-ebs": "25",
				"cpu": "2",
				"ephemeral-storage": "20959212Ki",
				"hugepages-1Gi": "0",
				"hugepages-2Mi": "0",
				"memory": "3967480Ki",
				"pods": "17",
			},
			"allocatable": {
				"attachable-volumes-aws-ebs": "25",
				"cpu": "1930m",
				"ephemeral-storage": "18242267924",
				"hugepages-1Gi": "0",
				"hugepages-2Mi": "0",
				"memory": "3412472Ki",
				"pods": "17",
			},
			"conditions": [
				{
					"type": "MemoryPressure",
					"status": "False",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:16Z",
					"reason": "KubeletHasSufficientMemory",
					"message": "kubelet has sufficient memory available",
				},
				{
					"type": "DiskPressure",
					"status": "False",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:16Z",
					"reason": "KubeletHasNoDiskPressure",
					"message": "kubelet has no disk pressure",
				},
				{
					"type": "PIDPressure",
					"status": "False",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:16Z",
					"reason": "KubeletHasSufficientPID",
					"message": "kubelet has sufficient PID available",
				},
				{
					"type": "Ready",
					"status": "True",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:37Z",
					"reason": "KubeletReady",
					"message": "kubelet is posting ready status",
				},
			],
			"addresses": [
				{
					"type": "InternalIP",
					"address": "192.168.54.45",
				},
				{
					"type": "ExternalIP",
					"address": "18.119.116.97",
				},
				{
					"type": "Hostname",
					"address": "ip-192-168-54-45.us-east-2.compute.internal",
				},
				{
					"type": "InternalDNS",
					"address": "ip-192-168-54-45.us-east-2.compute.internal",
				},
				{
					"type": "ExternalDNS",
					"address": "ec2-18-119-116-97.us-east-2.compute.amazonaws.com",
				},
			],
			"daemonEndpoints": {"kubeletEndpoint": {"Port": 10250}},
			"nodeInfo": {
				"machineID": "ec24394290717d18c2ef592d510bb612",
				"systemUUID": "ec243942-9071-7d18-c2ef-592d510bb612",
				"bootID": "38c7da10-4254-494a-b134-c35b5d483000",
				"kernelVersion": "5.4.156-83.273.amzn2.x86_64",
				"osImage": "Amazon Linux 2",
				"containerRuntimeVersion": "docker://20.10.7",
				"kubeletVersion": "v1.21.5-eks-bc4871b",
				"kubeProxyVersion": "v1.21.5-eks-bc4871b",
				"operatingSystem": "linux",
				"architecture": "amd64",
			},
		},
	},
}

valid_input_no_external_IP = {
	"type": "kube-api",
	"resource": {
		"kind": "Node",
		"status": {
			"capacity": {
				"attachable-volumes-aws-ebs": "25",
				"cpu": "2",
				"ephemeral-storage": "20959212Ki",
				"hugepages-1Gi": "0",
				"hugepages-2Mi": "0",
				"memory": "3967480Ki",
				"pods": "17",
			},
			"allocatable": {
				"attachable-volumes-aws-ebs": "25",
				"cpu": "1930m",
				"ephemeral-storage": "18242267924",
				"hugepages-1Gi": "0",
				"hugepages-2Mi": "0",
				"memory": "3412472Ki",
				"pods": "17",
			},
			"conditions": [
				{
					"type": "MemoryPressure",
					"status": "False",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:16Z",
					"reason": "KubeletHasSufficientMemory",
					"message": "kubelet has sufficient memory available",
				},
				{
					"type": "DiskPressure",
					"status": "False",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:16Z",
					"reason": "KubeletHasNoDiskPressure",
					"message": "kubelet has no disk pressure",
				},
				{
					"type": "PIDPressure",
					"status": "False",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:16Z",
					"reason": "KubeletHasSufficientPID",
					"message": "kubelet has sufficient PID available",
				},
				{
					"type": "Ready",
					"status": "True",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:37Z",
					"reason": "KubeletReady",
					"message": "kubelet is posting ready status",
				},
			],
			"addresses": [
				{
					"type": "InternalIP",
					"address": "192.168.54.45",
				},
				{
					"type": "Hostname",
					"address": "ip-192-168-54-45.us-east-2.compute.internal",
				},
				{
					"type": "InternalDNS",
					"address": "ip-192-168-54-45.us-east-2.compute.internal",
				},
				{
					"type": "ExternalDNS",
					"address": "ec2-18-119-116-97.us-east-2.compute.amazonaws.com",
				},
			],
			"daemonEndpoints": {"kubeletEndpoint": {"Port": 10250}},
			"nodeInfo": {
				"machineID": "ec24394290717d18c2ef592d510bb612",
				"systemUUID": "ec243942-9071-7d18-c2ef-592d510bb612",
				"bootID": "38c7da10-4254-494a-b134-c35b5d483000",
				"kernelVersion": "5.4.156-83.273.amzn2.x86_64",
				"osImage": "Amazon Linux 2",
				"containerRuntimeVersion": "docker://20.10.7",
				"kubeletVersion": "v1.21.5-eks-bc4871b",
				"kubeProxyVersion": "v1.21.5-eks-bc4871b",
				"operatingSystem": "linux",
				"architecture": "amd64",
			},
		},
	},
}

valid_input_external_IP_set_to_local_host = {
	"type": "kube-api",
	"resource": {
		"kind": "Node",
		"status": {
			"capacity": {
				"attachable-volumes-aws-ebs": "25",
				"cpu": "2",
				"ephemeral-storage": "20959212Ki",
				"hugepages-1Gi": "0",
				"hugepages-2Mi": "0",
				"memory": "3967480Ki",
				"pods": "17",
			},
			"allocatable": {
				"attachable-volumes-aws-ebs": "25",
				"cpu": "1930m",
				"ephemeral-storage": "18242267924",
				"hugepages-1Gi": "0",
				"hugepages-2Mi": "0",
				"memory": "3412472Ki",
				"pods": "17",
			},
			"conditions": [
				{
					"type": "MemoryPressure",
					"status": "False",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:16Z",
					"reason": "KubeletHasSufficientMemory",
					"message": "kubelet has sufficient memory available",
				},
				{
					"type": "DiskPressure",
					"status": "False",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:16Z",
					"reason": "KubeletHasNoDiskPressure",
					"message": "kubelet has no disk pressure",
				},
				{
					"type": "PIDPressure",
					"status": "False",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:16Z",
					"reason": "KubeletHasSufficientPID",
					"message": "kubelet has sufficient PID available",
				},
				{
					"type": "Ready",
					"status": "True",
					"lastHeartbeatTime": "2022-02-12T08:33:32Z",
					"lastTransitionTime": "2021-11-30T09:44:37Z",
					"reason": "KubeletReady",
					"message": "kubelet is posting ready status",
				},
			],
			"addresses": [
				{
					"type": "InternalIP",
					"address": "192.168.54.45",
				},
				{
					"type": "ExternalIP",
					"address": "0.0.0.0",
				},
				{
					"type": "Hostname",
					"address": "ip-192-168-54-45.us-east-2.compute.internal",
				},
				{
					"type": "InternalDNS",
					"address": "ip-192-168-54-45.us-east-2.compute.internal",
				},
				{
					"type": "ExternalDNS",
					"address": "ec2-18-119-116-97.us-east-2.compute.amazonaws.com",
				},
			],
			"daemonEndpoints": {"kubeletEndpoint": {"Port": 10250}},
			"nodeInfo": {
				"machineID": "ec24394290717d18c2ef592d510bb612",
				"systemUUID": "ec243942-9071-7d18-c2ef-592d510bb612",
				"bootID": "38c7da10-4254-494a-b134-c35b5d483000",
				"kernelVersion": "5.4.156-83.273.amzn2.x86_64",
				"osImage": "Amazon Linux 2",
				"containerRuntimeVersion": "docker://20.10.7",
				"kubeletVersion": "v1.21.5-eks-bc4871b",
				"kubeProxyVersion": "v1.21.5-eks-bc4871b",
				"operatingSystem": "linux",
				"architecture": "amd64",
			},
		},
	},
}
