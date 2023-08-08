package compliance.cis_gcp.rules.cis_6_3_1

import data.compliance.policy.gcp.sql.ensure_db_flag as audit

finding = audit.finding("external scripts enabled", "off", true)
