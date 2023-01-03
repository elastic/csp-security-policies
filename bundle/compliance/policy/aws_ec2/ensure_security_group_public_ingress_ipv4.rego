package compliance.policy.aws_ec2.ensure_security_group_public_ingress_ipv4

import data.compliance.lib.common
import data.compliance.policy.aws_ec2.data_adapter
import data.compliance.policy.aws_ec2.ports
import future.keywords.every

default rule_evaluation = false

finding = result {
	# filter 
	data_adapter.is_security_group_policy

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(rule_evaluation),
		data_adapter.security_groups_ip_permissions,
	)
}

rule_evaluation {
	every entry in data_adapter.all_ipv4(data_adapter.security_groups_ip_permissions) {
		every port in ports.admin_ports {
			not ports.in_range(entry.FromPort, entry.ToPort, port)
		}
	}
}
