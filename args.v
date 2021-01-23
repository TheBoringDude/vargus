module vargus

import os

// OS Arguments struct
struct Args {
mut:
	arguments map[string]string
pub:
	command string
}

// returns the arguments parsed to the app
// excluding itself
fn (a Args) get_args() []string {
	return os.args[1..os.args.len]
}

fn (a Args) args_has_hyphen_dash(arg string) bool {
	return arg.starts_with('-') || arg.starts_with('--')
}

// extract all arguments which starts
// with -- or -
fn (mut a Args) extract_args() map[string]string {
	// get arguments
	args := a.get_args()
	for index, arg in args {
		if a.args_has_hyphen_dash(arg) {
			mut dat := ''
			if args.len > index + 1 {
				dat = args[index + 1]
			}
			// set the data
			a.arguments[arg.replace('--', '').replace('-', '')] = dat
		}
	}
	return a.arguments
}
