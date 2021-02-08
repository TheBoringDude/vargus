// CUSTOM SIMPLE VALIDATORS

module vargus

const nums = '0123456789'.split('')

// valid_number is a number validator
fn valid_number(y string) bool {
	// split y string
	x := y.split('')

	// valid var
	mut temp_valid := false
	
	for k, i in x {
		if i in vargus.nums {
			temp_valid = true
		} else {
			// a dash should only be in the beginning
			if k == 0 && i == '-' {
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
	if '.' in x {
		return false
	}

	return valid_number(x)
}


fn float_validator(x string) bool {
	// float numbers should contain only a single '.'
	if x.count('.') > 1 {
		return false
	}

	// remove dot for number validation
	return valid_number(x.replace('.', ''))
}