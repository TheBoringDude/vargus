module vargus

// required_err shows `-$flag is required error but is not set`
fn (c &Commander) required_err(fl_name string, fl_shortarg string) {
	mut flag_str := ''

	if fl_name != '' {
		flag_str = '--$fl_name'
	}
	if fl_shortarg != '' {
		if flag_str != '' {
			flag_str += ', '
		}
		flag_str += '-$fl_shortarg'
	}

	println('\n [!err] flag: $flag_str is required but is not set')
}

// value_err shows error about invalid data type value set in a flag
fn (c &Commander) value_err(flag string, ftype string) {
	println('\n [!value_err] invalid data type for a $ftype flag ($flag)')
}

// blank_err shows error if no value is set to the flag
fn (c &Commander) blank_err(flag string) {
	println('\n [!blank] no value set for flag: $flag')
}

// flag_err shows error if flag is missing from the defined flags
fn flag_err(flag string) {
	panic('\n [!flag_err] flag name: $flag is missing in the flags set for command')
}

// unknown_err shows error if flag in args is unknown
fn (c &Commander) unknown_err(flag string) {
	println('\n [!err] unknown flag: $flag')
}

// command_err shows error if command is unknown or not in sub_commands
fn (c &Commander) command_err(command string) {
	println('\n [!err] unknown command: $command')
}


// SET CUSTOM ERROR FUNCTIONS


// set_custom_err_required sets a custom error function for required
pub fn (mut c Commander) set_custom_err_required(f fn (x string, y string)) {
	c.config.errors.required = f
	c.config.errors.use_custom_required = true
}

// set_custom_err_value sets a custom error function for value
pub fn (mut c Commander) set_custom_err_value(f fn (x string, y string)) {
	c.config.errors.value = f
	c.config.errors.use_custom_value = true
}

// set_custom_err_blank sets a custom error function for blank
pub fn (mut c Commander) set_custom_err_blank(f fn (x string)) {
	c.config.errors.blank = f
	c.config.errors.use_custom_blank = true
}

// set_custom_err_unknown sets a custom error function for unknown
pub fn (mut c Commander) set_custom_err_unknown(f fn (x string)) {
	c.config.errors.unknown = f
	c.config.errors.use_custom_unknown = true
}

// set_custom_err_command sets a custom error function for command
pub fn (mut c Commander) set_custom_err_command(f fn (x string)) {
	c.config.errors.command = f
	c.config.errors.use_custom_command = true
}
