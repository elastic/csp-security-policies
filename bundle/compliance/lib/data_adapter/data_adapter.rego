package compliance.lib.data_adapter

is_process {
	input.type == "process"
}

process_name = name {
	is_process
	name = input.resource.stat.Name
}

process_args_list = args_list {
	is_process

	# Gets all the process arguments of the current process
	# Expects format as the following: --<key><delimiter><value> for example: --config=a.json
	# Notice that the first argument is always the process path
	args_list := split(input.resource.command, " --")
}

# This method creates a process args object
# The object will contain all the process `flags` and their matching values as object key,value accordingly
process_args(delimiter) = {flag: value | [flag, value] = parse_argument(process_args_list[_], delimiter)}

parse_argument(argument, delimiter) = [flag, value] {
	splitted_argument = split(argument, delimiter)
	flag = concat("", ["--", splitted_argument[0]])

	# We would like to take the entire string after the first delimiter
	value = concat(delimiter, array.slice(splitted_argument, 1, count(splitted_argument) + 1))
}

process_config = config {
	is_process
	config := {key: value | value = input.resource.external_data[key]}
}

is_kube_apiserver {
	process_name == "kube-apiserver"
}

is_kube_controller_manager {
	process_name == "kube-controller"
}

is_kube_scheduler {
	process_name == "kube-scheduler"
}

is_etcd {
	process_name == "etcd"
}

is_kubelet {
	process_name == "kubelet"
}

# TODO: Remove after refactoring of EKS 5.4.3 to use data_adapter instead of input directly
is_kube_api {
	input.type == "k8s_object"
}

# TODO: Remove after refactoring of EKS 5.4.3 to use data_adapter instead of input directly
is_kube_node {
	is_kube_api
	input.resource.kind == "Node"
}
