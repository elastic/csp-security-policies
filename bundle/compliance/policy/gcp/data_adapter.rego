package compliance.policy.gcp.data_adapter

import data.compliance.lib.common

resource = input.resource.resource

iam_policy = input.resource.iam_policy

has_policy = common.contains_key(input.resource, "iam_policy")

is_gke_instance(instance) {
	startswith(instance.name, "gke-")
}

is_sql_server {
	startswith(resource.data.databaseVersion, "SQLSERVER")
}

is_cloud_my_sql {
	startswith(resource.data.databaseVersion, "MYSQL")
}

is_https_lb {
	resource.data.protocol == "HTTPS"
}

is_postgres_sql {
	startswith(resource.data.databaseVersion, "POSTGRES")
}
