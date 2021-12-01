package compliance.lib.common

NS_FACTOR = 1000000000 # seconds to nano seconds factor

metadata = {"opa_version": opa_version}

# get OPA version
opa_version := opa.runtime().version

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

# checks if a value is greater or equals to a minimum value
greater_or_equal(value, minimum) {
	to_number(value) >= minimum
} else = false {
	true
}

# checks if duration is greater than some minimum value
# duration: string (https://pkg.go.dev/time#ParseDuration)
duration_gt(duration, min_duration) {
	duration_ns := time.parse_duration_ns(duration)
	min_duration_ns := time.parse_duration_ns(min_duration)
	duration_ns >= min_duration_ns
} else = false {
	true
}

# checks if duration is greater or equal to some minimum value
# duration: string (https://pkg.go.dev/time#ParseDuration)
duration_gt(duration, min_duration) {
	duration_ns := time.parse_duration_ns(duration)
	min_duration_ns := time.parse_duration_ns(min_duration)
	duration_ns > min_duration_ns
} else = false {
	true
}

# check if file is in path
file_in_path(path, file_path) {
	closed_path := concat("", [file_path, "/"]) # make sure last dir name is closed by "/"
	contains(closed_path, path)
}
