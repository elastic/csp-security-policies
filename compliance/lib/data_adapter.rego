package compliance.lib.data_adapter

is_filesystem {
	input.type == "filesystem"
}

filename = file_name {
	is_filesystem
	file_name = input.filename
}

filemode = file_mode {
	is_filesystem
	file_mode = input.mode
}

owner_user_id = uid {
	is_filesystem
	uid = input.uid
}

owner_group_id = gid {
	is_filesystem
	gid = input.gid
}

is_process {
	input.type == "process"
}

command_args = args {
	is_process
	args = input.command
}
