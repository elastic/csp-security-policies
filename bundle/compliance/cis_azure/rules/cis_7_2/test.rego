package compliance.cis_azure.rules.cis_7_2

import data.compliance.policy.azure.data_adapter
import data.lib.test

valid_managed_disk = {
	"id": "/subscriptions/sub-id/resourceGroups/cloudbeat-resource-group-1695893762/providers/Microsoft.Compute/disks/cloudbeatVM_OsDisk_1_e736df07f12142a9a2784ea8de9084ce",
	"resourceGroup": "cloudbeat-resource-group-1695893762",
	"storageAccountType": "Standard_LRS",
}

generate_vm(managed_disk) = {
	"type": "azure-vm",
	"subType": "",
	"resource": {
		"extendedLocation": null,
		"id": "/subscriptions/sub-id/resourceGroups/CLOUDBEAT-RESOURCE-GROUP-1695893762/providers/Microsoft.Compute/virtualMachines/CLOUDBEATVM",
		"identity": {
			"principalId": "8536c470-6db4-45b7-a083-b494b3f8481c",
			"tenantId": "tenant-id",
			"type": "SystemAssigned",
		},
		"kind": "",
		"location": "eastus",
		"managedBy": "",
		"name": "cloudbeatVM",
		"plan": null,
		"properties": {
			"extended": {"instanceView": {
				"computerName": "cloudbeatVM",
				"hyperVGeneration": "V2",
				"osName": "ubuntu",
				"osVersion": "22.04",
				"powerState": {
					"code": "PowerState/running",
					"displayStatus": "VM running",
					"level": "Info",
				},
			}},
			"hardwareProfile": {"vmSize": "Standard_DS2_v2"},
			"networkProfile": {"networkInterfaces": [{
				"id": "/subscriptions/sub-id/resourceGroups/cloudbeat-resource-group-1695893762/providers/Microsoft.Network/networkInterfaces/cloudbeatNic",
				"resourceGroup": "cloudbeat-resource-group-1695893762",
			}]},
			"osProfile": {
				"adminUsername": "cloudbeat",
				"allowExtensionOperations": true,
				"computerName": "cloudbeatVM",
				"linuxConfiguration": {
					"disablePasswordAuthentication": false,
					"enableVMAgentPlatformUpdates": false,
					"patchSettings": {
						"assessmentMode": "ImageDefault",
						"patchMode": "ImageDefault",
					},
					"provisionVMAgent": true,
				},
				"requireGuestProvisionSignal": true,
				"secrets": [],
			},
			"provisioningState": "Succeeded",
			"storageProfile": {
				"dataDisks": [],
				"diskControllerType": "SCSI",
				"imageReference": {
					"exactVersion": "22.04.202309190",
					"offer": "0001-com-ubuntu-server-jammy",
					"publisher": "canonical",
					"sku": "22_04-lts-gen2",
					"version": "latest",
				},
				"osDisk": {
					"caching": "ReadWrite",
					"createOption": "FromImage",
					"deleteOption": "Detach",
					"diskSizeGB": 30,
					"managedDisk": managed_disk,
					"name": "cloudbeatVM_OsDisk_1_e736df07f12142a9a2784ea8de9084ce",
					"osType": "Linux",
				},
			},
			"timeCreated": "2023-09-28T09:36:20.316Z",
			"vmId": "a3842848-355a-42ab-9fb1-488587f301f3",
		},
		"resourceGroup": "cloudbeat-resource-group-1695893762",
		"sku": null,
		"subscriptionId": "sub-id",
		"tags": null,
		"tenantId": "tenant-id",
		"type": "microsoft.compute/virtualmachines",
		"zones": null,
	},
}

test_violation {
	eval_fail with input as generate_vm(null)
	eval_fail with input as generate_vm({})
	eval_fail with input as generate_vm({"data": "in", "unknown": "format"})
	eval_fail with input as generate_vm({"id": ""})
}

test_pass {
	eval_pass with input as generate_vm(valid_managed_disk)
}

test_not_evaluated {
	not_eval with input as {}
	not_eval with input as {"type": "other-type", "resource": {"properties": {"storageProfile": {"osDisk": {"managedDisk": {"id": "some-id"}}}}}}
}

eval_fail {
	test.assert_fail(finding) with data.benchmark_data_adapter as data_adapter
}

eval_pass {
	test.assert_pass(finding) with data.benchmark_data_adapter as data_adapter
}

not_eval {
	not finding with data.benchmark_data_adapter as data_adapter
}
