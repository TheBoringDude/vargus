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

	// show err
	println('\n [!err] flag: $flag_str is required but is not set')

	// exit app
	exit(0)
}