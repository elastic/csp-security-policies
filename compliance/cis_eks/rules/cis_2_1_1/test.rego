package compliance.cis_eks.rules.cis_2_1_1

import data.cis_eks.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as violating_input_all_logs_disabled
	test.assert_fail(finding) with input as violating_input_some_disabled
}

test_pass {
	test.assert_pass(finding) with input as non_violating_input
	test.assert_pass(finding) with input as non_violating_input
}

test_not_evaluated {
	not finding with input as not_evaluated_input
}

violating_input_all_logs_disabled = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:eks:us-east-2:704479110758:cluster/EKS-Elastic-agent-demo",
		"CertificateAuthority": {"Data": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeE1UQXlOekV4TVRVeE5Wb1hEVE14TVRBeU5URXhNVFV4TlZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSlQ3CnJQNEN6SlBRV25kYzArMEZKY1NZc1ZwWXN0SFJaMjR0R1JEdnpxcDFxOE9BK1NQUEloQmszUE9MWjdMbnhRSlAKM0V2U1owVG1LNzljdUJWUUlvQjR5UHZrTUxOSjZWaGlBdEhmaGNGMmYzV3ZST3poOW1NWEVRNUZEcVNVUTNMbwphY2wxNTdpWUI5QWlsODVHODcwSDZjZXZQcU51N3hXZlV6UXo3aXhrczNXRDlOWE1EZFB2bERNeXJaUDBudWwxCm5hNGZPV3FDN3pWNFJpTlZJYVNoNnZQNWxqZUJNUjJFc1FTMnIyNmppQzhCU09WS3g2MmV3NDUwbDRNOEJMTngKYmp5UVYrZ25wSFpldk5HL1pFc3BWQkxkUTlucFJrb3J6RUNRNHFHRDBiRTBzRHd3YjdnVkxva0NQSHozTTh3agpSR0t0TVZQc1VON0pkMjVVYVU4Q0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZPNmRvY0x1NEVOS1k5SFphcTJteWdaOFNqdFRNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFCMkJidndSUU8vK0l4ZFRyVDRkYUdHd3J1TWVzSm5Fb3dXOWZmMnJXVVVJOThqTGM5dgprZDJGQkc4QkhzRjJnMDBzdGR3MUJ1UkE3R2ZZTmxaUGQwVllDdkJLbkxTZEsvVEo2UEFzM08xcG5OY0ZaZ0NJCkJydmpEMldNT3ZJdlZWdklLWEE5QmdXT1d6bzQvMU1RK1ZtY24yZEF0YTlWNVU4ZUMxcHFSV08xWHFhWC9vRW0KMUtPVkVIRGZhVFh4ei80RmlTazBSbHIzWkNFTlhLeGFiZFFscDFNRDM2RkpJVTEvOGk0ZWYwc2hJN2FuTGdQcQprTlg0WktDK3ZpOFFTT01PRVloS3VWcEx5OFpwd3owcUduUERtZ096eUcrc2UrZW9MTm9KdTlrV1ZOZUN2M2VFCjBMNXBXRkRVcHQreGZmKzREbjZCdmdxbTQyTmhERitxZjNoKwotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": null,
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBEDB096B808626B023DDBF7520DC"}},
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
		"Name": "EKS-Elastic-agent-demo",
	}},
}

violating_input_some_disabled = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:eks:us-east-2:704479110758:cluster/EKS-Elastic-agent-demo",
		"CertificateAuthority": {"Data": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeE1UQXlOekV4TVRVeE5Wb1hEVE14TVRBeU5URXhNVFV4TlZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSlQ3CnJQNEN6SlBRV25kYzArMEZKY1NZc1ZwWXN0SFJaMjR0R1JEdnpxcDFxOE9BK1NQUEloQmszUE9MWjdMbnhRSlAKM0V2U1owVG1LNzljdUJWUUlvQjR5UHZrTUxOSjZWaGlBdEhmaGNGMmYzV3ZST3poOW1NWEVRNUZEcVNVUTNMbwphY2wxNTdpWUI5QWlsODVHODcwSDZjZXZQcU51N3hXZlV6UXo3aXhrczNXRDlOWE1EZFB2bERNeXJaUDBudWwxCm5hNGZPV3FDN3pWNFJpTlZJYVNoNnZQNWxqZUJNUjJFc1FTMnIyNmppQzhCU09WS3g2MmV3NDUwbDRNOEJMTngKYmp5UVYrZ25wSFpldk5HL1pFc3BWQkxkUTlucFJrb3J6RUNRNHFHRDBiRTBzRHd3YjdnVkxva0NQSHozTTh3agpSR0t0TVZQc1VON0pkMjVVYVU4Q0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZPNmRvY0x1NEVOS1k5SFphcTJteWdaOFNqdFRNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFCMkJidndSUU8vK0l4ZFRyVDRkYUdHd3J1TWVzSm5Fb3dXOWZmMnJXVVVJOThqTGM5dgprZDJGQkc4QkhzRjJnMDBzdGR3MUJ1UkE3R2ZZTmxaUGQwVllDdkJLbkxTZEsvVEo2UEFzM08xcG5OY0ZaZ0NJCkJydmpEMldNT3ZJdlZWdklLWEE5QmdXT1d6bzQvMU1RK1ZtY24yZEF0YTlWNVU4ZUMxcHFSV08xWHFhWC9vRW0KMUtPVkVIRGZhVFh4ei80RmlTazBSbHIzWkNFTlhLeGFiZFFscDFNRDM2RkpJVTEvOGk0ZWYwc2hJN2FuTGdQcQprTlg0WktDK3ZpOFFTT01PRVloS3VWcEx5OFpwd3owcUduUERtZ096eUcrc2UrZW9MTm9KdTlrV1ZOZUN2M2VFCjBMNXBXRkRVcHQreGZmKzREbjZCdmdxbTQyTmhERitxZjNoKwotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": null,
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBEDB096B808626B023DDBF7520DC"}},
		"Logging": {"ClusterLogging": [
			{
				"Enabled": false,
				"Types": [
					"authenticator",
					"controllerManager",
					"scheduler",
				],
			},
			{
				"Enabled": true,
				"Types": [
					"api",
					"audit",
				],
			},
		]},
		"Name": "EKS-Elastic-agent-demo",
	}},
}

non_violating_input = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:eks:us-east-2:704479110758:cluster/EKS-Elastic-agent-demo",
		"CertificateAuthority": {"Data": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeE1UQXlOekV4TVRVeE5Wb1hEVE14TVRBeU5URXhNVFV4TlZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSlQ3CnJQNEN6SlBRV25kYzArMEZKY1NZc1ZwWXN0SFJaMjR0R1JEdnpxcDFxOE9BK1NQUEloQmszUE9MWjdMbnhRSlAKM0V2U1owVG1LNzljdUJWUUlvQjR5UHZrTUxOSjZWaGlBdEhmaGNGMmYzV3ZST3poOW1NWEVRNUZEcVNVUTNMbwphY2wxNTdpWUI5QWlsODVHODcwSDZjZXZQcU51N3hXZlV6UXo3aXhrczNXRDlOWE1EZFB2bERNeXJaUDBudWwxCm5hNGZPV3FDN3pWNFJpTlZJYVNoNnZQNWxqZUJNUjJFc1FTMnIyNmppQzhCU09WS3g2MmV3NDUwbDRNOEJMTngKYmp5UVYrZ25wSFpldk5HL1pFc3BWQkxkUTlucFJrb3J6RUNRNHFHRDBiRTBzRHd3YjdnVkxva0NQSHozTTh3agpSR0t0TVZQc1VON0pkMjVVYVU4Q0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZPNmRvY0x1NEVOS1k5SFphcTJteWdaOFNqdFRNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFCMkJidndSUU8vK0l4ZFRyVDRkYUdHd3J1TWVzSm5Fb3dXOWZmMnJXVVVJOThqTGM5dgprZDJGQkc4QkhzRjJnMDBzdGR3MUJ1UkE3R2ZZTmxaUGQwVllDdkJLbkxTZEsvVEo2UEFzM08xcG5OY0ZaZ0NJCkJydmpEMldNT3ZJdlZWdklLWEE5QmdXT1d6bzQvMU1RK1ZtY24yZEF0YTlWNVU4ZUMxcHFSV08xWHFhWC9vRW0KMUtPVkVIRGZhVFh4ei80RmlTazBSbHIzWkNFTlhLeGFiZFFscDFNRDM2RkpJVTEvOGk0ZWYwc2hJN2FuTGdQcQprTlg0WktDK3ZpOFFTT01PRVloS3VWcEx5OFpwd3owcUduUERtZ096eUcrc2UrZW9MTm9KdTlrV1ZOZUN2M2VFCjBMNXBXRkRVcHQreGZmKzREbjZCdmdxbTQyTmhERitxZjNoKwotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": null,
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBEDB096B808626B023DDBF7520DC"}},
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

non_violating_input_wrong_structre = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:eks:us-east-2:704479110758:cluster/EKS-Elastic-agent-demo",
		"CertificateAuthority": {"Data": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeE1UQXlOekV4TVRVeE5Wb1hEVE14TVRBeU5URXhNVFV4TlZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSlQ3CnJQNEN6SlBRV25kYzArMEZKY1NZc1ZwWXN0SFJaMjR0R1JEdnpxcDFxOE9BK1NQUEloQmszUE9MWjdMbnhRSlAKM0V2U1owVG1LNzljdUJWUUlvQjR5UHZrTUxOSjZWaGlBdEhmaGNGMmYzV3ZST3poOW1NWEVRNUZEcVNVUTNMbwphY2wxNTdpWUI5QWlsODVHODcwSDZjZXZQcU51N3hXZlV6UXo3aXhrczNXRDlOWE1EZFB2bERNeXJaUDBudWwxCm5hNGZPV3FDN3pWNFJpTlZJYVNoNnZQNWxqZUJNUjJFc1FTMnIyNmppQzhCU09WS3g2MmV3NDUwbDRNOEJMTngKYmp5UVYrZ25wSFpldk5HL1pFc3BWQkxkUTlucFJrb3J6RUNRNHFHRDBiRTBzRHd3YjdnVkxva0NQSHozTTh3agpSR0t0TVZQc1VON0pkMjVVYVU4Q0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZPNmRvY0x1NEVOS1k5SFphcTJteWdaOFNqdFRNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFCMkJidndSUU8vK0l4ZFRyVDRkYUdHd3J1TWVzSm5Fb3dXOWZmMnJXVVVJOThqTGM5dgprZDJGQkc4QkhzRjJnMDBzdGR3MUJ1UkE3R2ZZTmxaUGQwVllDdkJLbkxTZEsvVEo2UEFzM08xcG5OY0ZaZ0NJCkJydmpEMldNT3ZJdlZWdklLWEE5QmdXT1d6bzQvMU1RK1ZtY24yZEF0YTlWNVU4ZUMxcHFSV08xWHFhWC9vRW0KMUtPVkVIRGZhVFh4ei80RmlTazBSbHIzWkNFTlhLeGFiZFFscDFNRDM2RkpJVTEvOGk0ZWYwc2hJN2FuTGdQcQprTlg0WktDK3ZpOFFTT01PRVloS3VWcEx5OFpwd3owcUduUERtZ096eUcrc2UrZW9MTm9KdTlrV1ZOZUN2M2VFCjBMNXBXRkRVcHQreGZmKzREbjZCdmdxbTQyTmhERitxZjNoKwotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": null,
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBEDB096B808626B023DDBF7520DC"}},
		"Logging": {"WrongField": [{
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

not_evaluated_input = {
	"type": "some-type",
	"resource": {"Cluster": {
		"Arn": "arn:aws:eks:us-east-2:704479110758:cluster/EKS-Elastic-agent-demo",
		"CertificateAuthority": {"Data": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeE1UQXlOekV4TVRVeE5Wb1hEVE14TVRBeU5URXhNVFV4TlZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSlQ3CnJQNEN6SlBRV25kYzArMEZKY1NZc1ZwWXN0SFJaMjR0R1JEdnpxcDFxOE9BK1NQUEloQmszUE9MWjdMbnhRSlAKM0V2U1owVG1LNzljdUJWUUlvQjR5UHZrTUxOSjZWaGlBdEhmaGNGMmYzV3ZST3poOW1NWEVRNUZEcVNVUTNMbwphY2wxNTdpWUI5QWlsODVHODcwSDZjZXZQcU51N3hXZlV6UXo3aXhrczNXRDlOWE1EZFB2bERNeXJaUDBudWwxCm5hNGZPV3FDN3pWNFJpTlZJYVNoNnZQNWxqZUJNUjJFc1FTMnIyNmppQzhCU09WS3g2MmV3NDUwbDRNOEJMTngKYmp5UVYrZ25wSFpldk5HL1pFc3BWQkxkUTlucFJrb3J6RUNRNHFHRDBiRTBzRHd3YjdnVkxva0NQSHozTTh3agpSR0t0TVZQc1VON0pkMjVVYVU4Q0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZPNmRvY0x1NEVOS1k5SFphcTJteWdaOFNqdFRNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFCMkJidndSUU8vK0l4ZFRyVDRkYUdHd3J1TWVzSm5Fb3dXOWZmMnJXVVVJOThqTGM5dgprZDJGQkc4QkhzRjJnMDBzdGR3MUJ1UkE3R2ZZTmxaUGQwVllDdkJLbkxTZEsvVEo2UEFzM08xcG5OY0ZaZ0NJCkJydmpEMldNT3ZJdlZWdklLWEE5QmdXT1d6bzQvMU1RK1ZtY24yZEF0YTlWNVU4ZUMxcHFSV08xWHFhWC9vRW0KMUtPVkVIRGZhVFh4ei80RmlTazBSbHIzWkNFTlhLeGFiZFFscDFNRDM2RkpJVTEvOGk0ZWYwc2hJN2FuTGdQcQprTlg0WktDK3ZpOFFTT01PRVloS3VWcEx5OFpwd3owcUduUERtZ096eUcrc2UrZW9MTm9KdTlrV1ZOZUN2M2VFCjBMNXBXRkRVcHQreGZmKzREbjZCdmdxbTQyTmhERitxZjNoKwotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": null,
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBEDB096B808626B023DDBF7520DC"}},
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
