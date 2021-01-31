module vargus

import os

// parser for global_flags
fn get_global_flags(cmd &Commander, os_args []string) ([]string, []FlagArgs) {
	mut oa := os_args.clone()
	mut fls := []FlagArgs{}
	
	for k, j in os_args {
		// break loop if the args is one of the subcommands
		if j in cmd.sub_commands_string {
			break
		}

		if args_has_hyphen_dash(j) && ((j.replace('-','') in cmd.global_flags_string) == false && (j.replace('-','') in cmd.local_flags_string) == false) {
			println('\n  [!err] unknown flag $j')
			exit(1)
		}
		for i in cmd.flags {
			if i.flag_type == .global {
				long := '--$i.name'
				short := '-$i.short_arg'

				mut fl := i

				if j == long || j == short {
					if i.data_type == .boolean {
						if os_args.len > 1 {
							if os_args[k+1] == 'true' || os_args[k+1] == 'false' {
								fl.value = os_args[k+1]

								// append
								fls << fl

								// remove
								oa.delete(k+1)
								oa.delete(k)
							} else {
								fl.value = 'true'

								fls << fl

								// remove
								oa.delete(k)
							}
						}
						 else {
							fl.value = 'true'

							fls << fl

							// remove
							oa.delete(k)
						}
					} else {
						fl.value = os_args[k+1]

						// append
						fls << fl

						// remove
						oa.delete(k+1)
						oa.delete(k)
					}
				}
			}
		}
	}

	return oa, fls
}

// parser for local_flags
fn parse_flags(cmd &Commander, os_args []string) ([]string, []FlagArgs) {
	mut flags := []FlagArgs{}
	mut oa := os_args.clone()

	for k, j in os_args {
		if args_has_hyphen_dash(j) && (j.replace('-','') in cmd.local_flags_string) == false {
			println('\n  [!err] unknown flag $j')
			exit(1)
		}
		for i in cmd.flags {
			if i.flag_type == .local {
				long := '--$i.name'
				short := '-$i.short_arg'

				mut fl := i

				if j == long || j == short {
					if i.data_type == .boolean {
						if os_args.len > 1 {
							if os_args[k+1] == 'true' || os_args[k+1] == 'false' {
								fl.value = os_args[k+1]

								// append
								flags << fl

								// remove
								oa.delete(k+1)
								oa.delete(k)
							} else {
								fl.value = 'true'

								flags << fl

								// remove
								oa.delete(k)
							}
						}
						 else {
							fl.value = 'true'

							flags << fl

							// remove
							oa.delete(k)
						}
					} else {
						fl.value = os_args[k+1]

						// append
						flags << fl

						// remove
						oa.delete(k+1)
						oa.delete(k)
					}
				}
			}
		}
	}

	// for i in cmd.flags {
	// 	long := '--$i.name'
	// 	short := '-$i.short_arg'

	// 	mut fl := i

	// 	for k, j in os_args {
	// 		if j == long || j == short {
	// 			fl.value = os_args[k+1]

	// 			// append
	// 			flags << fl

	// 			// remove
	// 			oa.delete(k)
	// 			oa.delete(k+1)
	// 		} else {
	// 			if args_has_hyphen_dash(j) {
	// 				println('  [!err] unknown flag $j')
	// 				exit(1)
	// 			}
	// 		}
	// 	}
	// }

	return oa, flags
}

// fn remove_flags(args []string) []string {
// 	for i in 
// }

fn (mut c Commander) extract_flags() {
	mut args := os.args[1..os.args.len]

	for mut flag in c.flags {
		long := '--$flag.name'
		short := '-$flag.short_arg'

		if long in args || short in args {
			if flag.name != '' {
				if flag.data_type == .boolean && args_has_hyphen_dash(args[args.index(long)]) {
					flag.value = '${!flag.default_value.bool()}'
				} else {
					flag.value = args[args.index(long)]
				}
			} else if flag.short_arg != '' {
				if flag.data_type == .boolean && args_has_hyphen_dash(args[args.index(short)]) {
					flag.value = '${!flag.default_value.bool()}'
				} else {
					flag.value = args[args.index(short)]
				}
			}
		}
	}

	// extract all flags included in the arguments
	// for mut i in c.flags {
	// 	f_arg := '--$i.name'
	// 	s_arg := '-$i.short_arg'

	// 	if f_arg in os.args || s_arg in os.args {
	// 		if i.name != '' {
	// 			if i.data_type == .boolean && args_has_hyphen_dash(os.args[os.args.index(f_arg)+1]) == true{
	// 				i.value = 'true'
	// 			} else {
	// 				i.value = os.args[os.args.index(f_arg)+1]
	// 			}
	// 		} else if i.short_arg != '' {
	// 			if i.data_type == .boolean && args_has_hyphen_dash(os.args[os.args.index(s_arg)+1]) == true{
	// 				i.value = 'true'
	// 			} else {
	// 				i.value = os.args[os.args.index(s_arg)+1]
	// 			}
	// 		}
	// 	}
	// }
	// for i, arg in os.args {
	// 	if args_has_hyphen_dash(arg) == true && args_has_hyphen_dash(os.args[i+1]) == false {
	// 		c.extracted_flags[arg] = os.args[i+1]
	// 	} else if args_has_hyphen_dash(arg) == true && args_has_hyphen_dash(os.args[i+1]) == true {
	// 		c.extracted_flags[arg] = os.args[i+1]
	// 	}
	// }
}

fn args_has_hyphen_dash(arg string) bool {
	return arg.starts_with('-') || arg.starts_with('--')
}

// import os

// // OS Arguments struct
// struct Args {
// mut:
// 	arguments map[string]string
// pub:
// 	command string
// }

// // returns the arguments parsed to the app
// // excluding itself
// fn (a Args) get_args() []string {
// 	return os.args[1..os.args.len]
// }

// fn (a Args) args_has_hyphen_dash(arg string) bool {
// 	return arg.starts_with('-') || arg.starts_with('--')
// }

// // extract all arguments which starts
// // with -- or -
// fn (mut a Args) extract_args() map[string]string {
// 	// get arguments
// 	args := a.get_args()
// 	for index, arg in args {
// 		if a.args_has_hyphen_dash(arg) {
// 			mut dat := ''
// 			if args.len > index + 1 {
// 				dat = args[index + 1]
// 			}
// 			// set the data
// 			a.arguments[arg] = dat
// 		}
// 	}
// 	return a.arguments
// }
