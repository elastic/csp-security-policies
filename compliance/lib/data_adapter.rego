package compliance.lib.data_adapter

is_filesystem {
	input.type == "file-system"
}

filename = file_name {
	is_filesystem
	file_name = input.filename
}

filemode = file_mode {
	is_filesystem
	file_mode = input.mode
}

file_path = path {
	is_filesystem
	path = input.path
}

owner_user_id = uid {
	is_filesystem
	uid = input.uid
}

owner_group_id = gid {
	is_filesystem
	gid = input.gid
}

get_process_args = args {
    args = {arg: value | [arg, value] = split(controller_manager_args_list[_], "=")}
}

is_controller_manager_process {
	input.type == "controller_manager"
}

controller_manager_args_list = args {
	is_controller_manager_process
	args = get_process_args
}

controller_manager_args = args {
	is_controller_manager_process
}

is_api_server_process {
	input.type == "api_server"
}

api_server_command_args = args {
	is_api_server_process
	args = get_process_args
}
