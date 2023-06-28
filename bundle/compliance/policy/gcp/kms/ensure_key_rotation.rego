package compliance.policy.gcp.kms.ensure_key_rotation

import data.compliance.lib.common
import data.compliance.policy.gcp.kms.data_adapter
import future.keywords.if

duration = sprintf("%dh", [90 * 24]) # 90 days converted to hours

default key_is_rotated = false

key_is_rotated if {
	common.date_within_duration(time.parse_rfc3339_ns(data_adapter.resource.data.nextRotationTime), duration)
	common.duration_lte(common.ConvertDaysToHours(data_adapter.resource.data.rotationPeriod), duration)
}
