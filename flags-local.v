module vargus

// add_local_flag_int handles adding of local flags to the command with integer value
pub fn (mut c Commander) add_local_flag_int(fc IntFlagConfig) {
	// append to list of flags
	c.flags << FlagArgs{
		name: fc.name
		short_arg: fc.short_arg
		required: fc.required
		default_value: fc.default_value.str()
		data_type: .integer
		flag_type: .local
		help: fc.help
	}
}

// add_local_flag_string handles adding of local flags to the command with string value
pub fn (mut c Commander) add_local_flag_string(fc StringFlagConfig) {
	// append to list of flags
	c.flags << FlagArgs{
		name: fc.name
		short_arg: fc.short_arg
		required: fc.required
		default_value: fc.default_value
		data_type: .string_var
		flag_type: .local
		help: fc.help
	}
}

// add_local_flag_float handles adding of local flags to the command with float value
pub fn (mut c Commander) add_local_flag_float(fc FloatFlagConfig) {
	// append to list of flags
	c.flags << FlagArgs{
		name: fc.name
		short_arg: fc.short_arg
		required: fc.required
		default_value: fc.default_value.str()
		data_type: .float
		flag_type: .local
		help: fc.help
	}
}

// add_local_flag_bool handles adding of local flags to the command with boolean value
pub fn (mut c Commander) add_local_flag_bool(fc BoolFlagConfig) {
	// append to list of flags
	c.flags << FlagArgs{
		name: fc.name
		short_arg: fc.short_arg
		required: fc.required
		default_value: fc.default_value.str()
		data_type: .boolean
		flag_type: .local
		help: fc.help
	}
}
