module vargus

// command_checker is a utility cmdconfig checker which checks if important fields are not set
fn command_checker(cmdConfig CmdConfig) {
	// check if command name is set
	if is_blank(cmdConfig.command) {
		eprintln('\n ![invalid] please set a command name for your cli app')
		exit(1)
	}

	// command description is required to be set
	if is_blank(cmdConfig.short_desc) && is_blank(cmdConfig.long_desc) {
		eprintln('\n ![invalid] a description should atleast be set, short or long')
		exit(1)
	}
}


// flag_checker is a utlity flag checker which checks if important fiels are set
fn flag_checker(flag_name string, flag_short_arg string) {
	if is_blank(flag_name) && is_blank(flag_short_arg) {
		eprintln('\n ![invalid] you should set a flag name or a short_arg')
		exit(1)
	}
}


// check_if_blank checks if a string is just a blank
fn is_blank(text string) bool {
	// remove space and check
	if text.trim_space() == '' {
		return true
	}
	
	return false
}