// CUSTOM SIMPLE VALIDATORS

module vargus

// valid_number is a number validator
fn valid_number(y string) bool {
	mut temp_valid := false

	for k, i in y {
		if i.is_digit() {
			temp_valid = true
		} else {
			// a dash should only be in the beginning
			if k == 0 && i == `-` {
				temp_valid = true
			} else {
				temp_valid = false
				break // stop loop once false
			}
		}
	}

	return temp_valid
}

// int_validator is a simple validator for integer strings
fn int_validator(x string) bool {
	// integers do not contain '.'
	if x.contains('.') {
		return false
	}

	return valid_number(x)
}

// float_validator is a simple validator for float strings
// TODO: IMPROVE THIS ONE
fn float_validator(x string) bool {
	// float numbers should contain only a single '.'
	if x.count('.') > 1 {
		return false
	}

	return valid_number(x.replace('.', '').replace('e', ''))
}

// bool_validator is a smple validator for bool strings
fn bool_validator(x string) bool {
	if x == 'false' || x == 'true' {
		return true
	}

	return false
}
