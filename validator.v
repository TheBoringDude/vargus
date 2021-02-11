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
	if '.' in x {
		return false
	}

	return valid_number(x)
}

// float_validator is a simple validator for float strings
fn float_validator(x string) bool {
	// float numbers should contain only a single '.'
	if x.count('.') > 1 {
		return false
	}

	mut xx := ''

	for k, i in x {
		if (i == `-` || i == `+`) && k != 0 {
			if x[k-1] == `.` {
				break
			} else if x[k-1] != `e` {
				return false
			} else {
				mut x_x := x.split('')

				if i == `-` {
					x_x.delete(x_x.index('-'))
				} else if i == `+` {
					x_x.delete(x_x.index('+'))
				}
				
				xx = x_x.join('')
				break
			}
		}
	}

	
	if xx != '' {
		// remove dot & e for number validation
		return valid_number(xx.replace('.', '').replace('e', ''))
	}

	// remove dot & e for number validation
	return valid_number(x.replace('.', '').replace('e', ''))
}