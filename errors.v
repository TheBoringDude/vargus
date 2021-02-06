module vargus

// required_err shows `-$flag is required error but is not set`
fn required_err(fl_name string, fl_shortarg string) {
	mut flag_str := ''

	if fl_name != '' {
		flag_str = '--$fl_name'
	}
	if fl_shortarg != ''{
		if flag_str != '' {
			flag_str += ', '
		}
		flag_str += '-$fl_shortarg'
	}

	println('\n [!err] flag: $flag_str is required but is not set')
	exit(0)
}


// value_err shows error about invalid data type value set in a flag
fn value_err(message string) {
	println('\n [!value_err] $message')
	exit(1)
}


// blank_err shows error if no value is set to the flag
fn blank_err(flag string) {
	println('\n [!blank] no value set for flag: $flag')
	exit(1)
}
