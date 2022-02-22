package compliance.lib.assert

is_false(value) {
	value == false
} else = false {
	true
}

all_true(values) {
	not some_false(values)
}

all_false(values) {
	not some_true(values)
}

some_false(values) {
	value := values[_]
	not value
}

some_true(values) {
	value := values[_]
	value
}

array_is_empty(array) {
	count(array) == 0
} else = false {
	true
}
