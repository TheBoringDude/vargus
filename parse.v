module vargus

// parse_flags is the main flag parser
// it parses all flags in the osargs
fn parse_flags(cmd &Commander, osargs []string, gflags []FlagArgs) ([]string, []FlagArgs) {
	mut flags := []FlagArgs{}
	mut args := osargs.clone()
	mut all_flags := cmd.flags.clone()

	// append
	all_flags << gflags

	// extract values
	for i in osargs {
		for ic, c in all_flags {
			mut x := c
			mut found := false
			mut flag_value := ''

			long := '--$c.name'
			short := '-$c.short_arg'

			if i.starts_with(long) || i.starts_with(short) {
				// check if equals sign is used
				if '=' in i {
					y := args[args.index(i)].split('=')
					flag := y[0]
					flag_value = y[1]

					if flag == long || flag == short {
						// set found
						found = true

						// remove from osargs
						args.delete(args.index(i))
					}
				} else {
					val := args[args.index(i)+1] or {
						''
					}

					if i == long || i == short {
						// simple validation for set values on flags
						flag_value = args[args.index(val)] or {
							if x.data_type != .boolean {
								// show blank error
								blank_err(i)
							}
							'' // it is needed, not sure xD
						}

						// set found
						found = true

						// remove from osargs
						if val != '' {
							// only delete from args if flag data_type is not boolean
							if x.data_type != .boolean {
								args.delete(args.index(val))
							}
						}
						
						if i in args {
							args.delete(args.index(i))
						} else {
							// show blank error
							blank_err(osargs[osargs.index(i)-1])
						}
					}
				}

				// if flag is present / parsed
				if found {
					// get value
					x.value = parse_value(flag_value, x.data_type, i, '')

					// append new flag w/ value to flags
					flags << x

					// remove old flag w/ value from all
					all_flags.delete(ic)
				}
			}
		}
	}

	
	prsd_helper_flags := parse_helper(all_flags)

	// append parsed flags from helper
	flags << prsd_helper_flags

	// another checker for flags
	validate_final_args(args)

	// return the final args and flags parsed
	return args, flags
}


// parse_value is a value parser and validator
//   it checks if set value's data_type is similar to flag's
fn parse_value(val string, dtype FlagDataType, flag string, flag_op string) string {
	mut value := ''

	// validate values
	match dtype {
		.string_var {
			value = val
		}
		.integer {
			if int_validator(val) {
				value = val
			} else {
				value_err(flag, 'int')
			}
		}
		.float {
			if float_validator(val) {
				value = val
			} else {
				value_err(flag, 'float')
			}
		}
		.boolean {
			if val == 'false' || val == 'true' {
				value = val
			} else {
				if flag_op == '=' {
					// if the value set is not equal to true or false,
					// show value error
					value_err(flag, 'bool')
				} else {
					// if the value set is not equal to true or false,
					// parse it but next arg will be parsed to args
					value = 'true'
				}
			}
		}
	}

	// return value
	return value
}

// parse_helper is a helper to the main parser
// it verifies values of flags and checks if they are required or not
fn parse_helper(flags []FlagArgs) []FlagArgs {
	mut fl := flags.clone()

	for mut i in fl {
		if i.value == '' {
			// if required show error
			if i.required == true {
				required_err(i.name, i.short_arg)
			}

			// otherwise, set value with default
			i.value = i.default_value
		}
	}

	return fl
}