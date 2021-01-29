module vargus

// fn check_required_err(flag FlagArgs) {
// 	mut flag_args := ''

// 	if flag.argument != '' {
// 		flag_args = '`--$flag.argument`'
// 		if flag.short_arg != '' {
// 			flag_args += ', '
// 		}
// 	}
// 	if flag.short_arg != '' {
// 		flag_args += '`-$flag.short_arg`'
// 	}

// 	if flag.required {
// 		println('\n  [!err] Flag $flag_args is required but is not set.')
// 		// exit the app
// 		exit(0)
// 	}
// }
