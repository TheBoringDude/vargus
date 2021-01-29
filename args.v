module vargus

import os

fn (mut c Commander) extract_flags() {
	// extract all flags included in the arguments
	for mut i in c.flags {
		f_arg := '--$i.name'
		s_arg := '-$i.short_arg'

		if f_arg in os.args || s_arg in os.args {
			if i.name != '' {
				if i.data_type == .boolean && args_has_hyphen_dash(os.args[os.args.index(f_arg)+1]) == true{
					i.value = 'true'
				} else {
					i.value = os.args[os.args.index(f_arg)+1]
				}
			} else if i.short_arg != '' {
				if i.data_type == .boolean && args_has_hyphen_dash(os.args[os.args.index(s_arg)+1]) == true{
					i.value = 'true'
				} else {
					i.value = os.args[os.args.index(s_arg)+1]
				}
			}
		}
	}
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
