module vargus

fn check_required_err(long_arg string, short_arg string, required bool) {
	mut flag_args := ''

	if long_arg != '' {
		flag_args = '`--$long_arg`'
		if short_arg != '' {
			flag_args += ', '
		}
	}
	if short_arg != '' {
		flag_args += '`-$short_arg`'
	}
	
	if required {
		println("\n  [!err] Flag $flag_args is required but is not set.")
		// exit the app
		exit(0)
	}
}