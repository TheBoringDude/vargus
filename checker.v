module vargus

// command_checker is a utility cmdconfig checker which checks if important fields are not set
fn command_checker(cmdConfig CmdConfig) {
	// check if command name is set
	if cmdConfig.command.trim_space() == '' {
		eprintln('\n ![invalid] please set a command name for your cli app')
		exit(1)
	}

	// command description is required to be set
	if cmdConfig.short_desc.trim_space() == '' && cmdConfig.long_desc.trim_space() == '' {
		eprintln('\n ![invalid] a description should atleast be set, short or long')
		exit(1)
	}
}


// flag_checker is a utlity flag checker which checks if important fiels are set
fn flag_checker(flag_name string, flag_short_arg string) {
	if flag_name.trim_space() == '' && flag_short_arg.trim_space() == '' {
		eprintln('\n ![invalid] you should set a flag name or a short_arg')
		exit(1)
	}
}