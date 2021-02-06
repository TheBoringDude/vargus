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

			long := '--$c.name'
			short := '-$c.short_arg'

			if i.starts_with(long) || i.starts_with(short) {
				// check if equals sign is used
				if '=' in i {
					y := args[args.index(i)].split('=')
					flag := y[0]
					value := y[1]

					if flag == long || flag == short {
						// smart handle for boolean flags
						// if it is equal, equals to true automatically
						if x.data_type == .boolean {
							if value == 'false' || value == 'true' {
								// do nothing
							} else {
								// if the value set is not equal to true or false,
								// show value error
								value_err('invalid type value for a boolean flag')
							}
						}
						// set value
						x.value = value

						// append new flag w/ value to flags
						flags << x

						// remove old flag w/ value from all
						all_flags.delete(ic)

						// remove from osargs
						args.delete(args.index(i))
					}
				} else {
					value := args[args.index(i)+1] or {
						''
					}

					if i == long || i == short {
						// smart handle for boolean flags
						// if it is equal, equals to true automatically
						if x.data_type == .boolean {
							if value == 'false' || value == 'true' {
								x.value = value
							} else {
								// if the value set is not equal to true or false,
								// parse it but next arg will be parsed to args
								x.value = 'true'
							}
						} else {
							x.value = args[args.index(value)] or {
								// show blank error
								blank_err(i)
								'' // it is needed, 
							}
						}

						// append new flag w/ value to flags
						flags << x

						// remove old flag w/ value from all
						all_flags.delete(ic)

						// remove from osargs
						if value != '' {
							// only delete from args if flag data_type is not boolean
							if x.data_type != .boolean {
								if args_has_hyphen_dash(value) {
									value_err('cannot use a flag as a value for a flag')
								} else {
									args.delete(args.index(value))
								}
							}
						}
						args.delete(args.index(i))
					}
				}
			}
		}
	}

	
	prsd_helper_flags := parse_helper(all_flags)

	// append parsed flags from helper
	flags << prsd_helper_flags

	return args, flags
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