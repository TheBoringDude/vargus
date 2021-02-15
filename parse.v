module vargus

// parse_flags is the main flag parser
// it parses all flags in the osargs
fn (c &Commander) parse_flags(osargs []string, gflags []FlagArgs, cfg CommandConfig) ([]string, []FlagArgs) {
	mut flags := []FlagArgs{}
	mut args := osargs.clone()
	mut all_flags := c.flags.clone()

	// append
	all_flags << gflags

	// extract values
	for i in osargs {
		for ic, cmd in all_flags {
			mut x := cmd
			mut found := false
			mut flag_value := ''
			mut f_op := ''

			long := '--$cmd.name'
			short := '-$cmd.short_arg'

			if i.starts_with(long) || i.starts_with(short) {
				// check if equals sign is used
				if '=' in i {
					y := args[args.index(i)].split('=')
					flag := y[0]
					flag_value = y[1]

					if flag == long || flag == short {
						// set found
						found = true

						f_op = '='

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
								if cfg.errors.use_custom_blank {
									cfg.errors.blank(i)
								} else {
									c.blank_err(i)
								}
								exit(1)
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
							if cfg.errors.use_custom_blank {
								cfg.errors.blank(osargs[osargs.index(i)-1])
							} else {
								c.blank_err(osargs[osargs.index(i)-1])
							}
							exit(1)
						}
					}
				}

				// if flag is present / parsed
				if found {
					// get value
					x.value = c.parse_value(flag_value, x.data_type, i, f_op, cfg)

					// append new flag w/ value to flags
					flags << x

					// remove old flag w/ value from all
					all_flags.delete(ic)
				}
			}
		}
	}

	
	prsd_helper_flags := c.parse_helper(all_flags, cfg)

	// append parsed flags from helper
	flags << prsd_helper_flags

	// another checker for flags
	c.validate_final_args(args)

	// return the final args and flags parsed
	return args, flags
}


// parse_value is a value parser and validator
//   it checks if set value's data_type is similar to flag's
fn (c &Commander) parse_value(val string, dtype FlagDataType, flag string, flag_op string, cfg CommandConfig) string {
	mut value := ''
	mut valid := false

	// validate values
	match dtype {
		.string_var {
			if cfg.validators.use_custom_string_var {
				valid = cfg.validators.string_var(val)
			} else {
				valid = true
			}
			
			if valid {
				value = val
			} else {
				if cfg.errors.use_custom_value {
					cfg.errors.value(flag, 'string')
				} else {
					c.value_err(flag, 'string')
				}
				exit(1)
			}
		}
		.integer {
			if cfg.validators.use_custom_integer {
				valid = cfg.validators.integer(val)
			} else {
				valid = int_validator(val)
			}

			if valid {
				value = val
			} else {
				if cfg.errors.use_custom_value {
					cfg.errors.value(flag, 'int')
				} else {
					c.value_err(flag, 'int')
				}
				exit(1)
			}
		}
		.float {
			if cfg.validators.use_custom_float {
				valid = cfg.validators.float(val)
			} else {
				valid = float_validator(val)
			}

			if valid {
				value = val
			} else {
				if cfg.errors.use_custom_value {
					cfg.errors.value(flag, 'float')
				} else {
					c.value_err(flag, 'float')
				}
				exit(1)
			}
		}
		.boolean {
			if cfg.validators.use_custom_boolean {
				valid = cfg.validators.boolean(val)
			} else {
				valid = bool_validator(val)
			}

			if valid {
				value = val
			} else {
				if flag_op == '=' {
					// if the value set is not equal to true or false,
					// show value error
					if cfg.errors.use_custom_value {
						cfg.errors.value(flag, 'bool')
					} else {
						c.value_err(flag, 'bool')
					}
					exit(1)
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
fn (c &Commander) parse_helper(flags []FlagArgs, cfg CommandConfig) []FlagArgs {
	mut fl := flags.clone()

	for mut i in fl {
		if i.value == '' {
			// if required show error
			if i.required == true {
				if cfg.errors.use_custom_required {
					cfg.errors.required(i.name, i.short_arg)
				} else {
					c.required_err(i.name, i.short_arg)
				}
				exit(1)
			}

			// otherwise, set value with default
			i.value = i.default_value
		}
	}

	return fl
}

// parse_config parses the config set if there is
fn (c &Commander) parse_config(p_config CommandConfig) CommandConfig {
	mut cfg := p_config

	if c.config.use_custom_help {
		cfg.custom_help = c.config.custom_help
	}

	// custom error messages
	if c.config.errors.use_custom_required {
		cfg.errors.required = c.config.errors.required
	}
	if c.config.errors.use_custom_value {
		cfg.errors.value = c.config.errors.value
	}
	if c.config.errors.use_custom_blank {
		cfg.errors.blank = c.config.errors.blank
	}
	if c.config.errors.use_custom_unknown {
		cfg.errors.unknown = c.config.errors.unknown
	}
	if c.config.errors.use_custom_command {
		cfg.errors.command = c.config.errors.command
	}
	// end custom error messages

	// custom flag validators
	if c.config.validators.use_custom_integer {
		cfg.validators.integer = c.config.validators.integer
	}
	if c.config.validators.use_custom_string_var {
		cfg.validators.string_var = c.config.validators.string_var
	}
	if c.config.validators.use_custom_float {
		cfg.validators.float = c.config.validators.float
	}
	if c.config.validators.use_custom_boolean {
		cfg.validators.boolean = c.config.validators.boolean
	}
	
	// return new config
	return cfg
}