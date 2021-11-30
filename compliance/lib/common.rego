package compliance.lib.common

# set the rule result
calculate_result(evaluation) = "passed" {
	evaluation
} else = "failed" {
	true
}

file_ownership_match(uid, gid, requierd_uid, requierd_gid) {
	uid == requierd_uid
	gid == requierd_gid
} else = false {
	true
}

# todo: compare performance of regex alternatives
file_permission_match(filemode, user, group, other) {
	pattern = sprintf("0?[0-%d][0-%d][0-%d]", [user, group, other])
	regex.match(pattern, filemode)
} else = false {
	true
}

array_contains(array, key) {
	contains(array[_], key)
} else = false {
	true
}

contains_key(object, key) {
	object[key]
} else = false {
	true
}

contains_key_with_value(object, key, value) {
	object[key] = value
} else = false {
	true
}


# checks if argument contains value (argument format is csv)
arg_values_contains(arguments, key, value) {
	argument := arguments[key]
	values := split(argument, ",")
	value == values[_]
} else = false {
	true
}

# checks if a argument is set to greater value then minimum
greater_or_equal(arguments, key, minimum) {
	value := arguments[key]
	to_number(value) >= minimum
} else = false {
	true
}
