package cis_gcp.test_data

generate_gcp_asset(type, subtype, resource, iam_policy) = {
	"resource": {
		"resource": resource,
		"iam_policy": iam_policy,
	},
	"type": type,
	"subType": subtype,
}

generate_iam_policy(members, role) = generate_gcp_asset(
	"key-management",
	"gcp-iam-service-account",
	{},
	{"bindings": [{"role": role, "members": members}]},
)

generate_monitoring_asset(log_metrics, alerts) = {
	"resource": {
		"log_metrics": log_metrics,
		"alerts": alerts,
	},
	"type": "monitoring",
	"subType": "gcp-monitoring",
}

generate_kms_resource(members, rotationPeriod, nextRotationTime, primary) = generate_gcp_asset(
	"key-management",
	"gcp-cloudkms-crypto-key",
	{"data": {"nextRotationTime": nextRotationTime, "rotationPeriod": rotationPeriod, "primary": primary}},
	{"bindings": [{"role": "roles/cloudkms.cryptoKeyEncrypterDecrypter", "members": members}]},
)

generate_gcs_resource(members, isBucketLevelAccessEnabled) = generate_gcp_asset(
	"cloud-storage",
	"gcp-storage-bucket",
	{"data": {"iamConfiguration": {"uniformBucketLevelAccess": {"enabled": isBucketLevelAccessEnabled}}}},
	{"bindings": [{"role": "roles/storage.objectViewer", "members": members}]},
)

generate_bq_resource(config, subType, members) = generate_gcp_asset(
	"cloud-storage",
	subType,
	{"data": {"defaultEncryptionConfiguration": config}},
	{"bindings": [{"role": "roles/bigquery.dataViewer", "members": members}]},
)

generate_compute_resource(subType, info) = generate_gcp_asset(
	"cloud-compute",
	subType,
	{"data": info},
	{},
)

generate_iam_service_account_key(resourceData) = generate_gcp_asset(
	"identity-management",
	"gcp-iam-service-account-key",
	{"data": resourceData},
	{},
)

not_eval_resource = generate_gcp_asset(
	"key-management",
	"non-existing-subtype",
	{},
	{},
)

no_policy_resource = generate_gcp_asset(
	"key-management",
	"gcp-iam",
	{},
	null, # missing resource.iam_policy
)
