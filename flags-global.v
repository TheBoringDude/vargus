module vargus

// add_global_flag_int handles adding of global flags to the command with integer value
pub fn (mut c Commander) add_global_flag_int(fc IntFlagConfig) {
	// initialize new flag instance
	flag := FlagArgs{
		name: fc.name
		short_arg: fc.short_arg
		required: fc.required
		default_value: fc.default_value.str()
		data_type: .integer
		flag_type: .global
		help: fc.help
	}

	// append to list of flags
	c.global_flags << flag
	c.global_flags_string << '--$flag.name'
	c.global_flags_string << '-$flag.short_arg'
}

// add_global_flag_string handles adding of global flags to the command with string value
pub fn (mut c Commander) add_global_flag_string(fc StringFlagConfig) {
	// initialize new flag instance
	flag := FlagArgs{
		name: fc.name
		short_arg: fc.short_arg
		required: fc.required
		default_value: fc.default_value
		data_type: .string_var
		flag_type: .global
		help: fc.help
	}

	// append to list of flags
	c.global_flags << flag
	c.global_flags_string << '--$flag.name'
	c.global_flags_string << '-$flag.short_arg'
}

// add_global_flag_float handles adding of global flags to the command with float value
pub fn (mut c Commander) add_global_flag_float(fc FloatFlagConfig) {
	// initialize new flag instance
	flag := FlagArgs{
		name: fc.name
		short_arg: fc.short_arg
		required: fc.required
		default_value: fc.default_value.str()
		data_type: .float
		flag_type: .global
		help: fc.help
	}

	// append to list of flags
	c.global_flags << flag
	c.global_flags_string << '--$flag.name'
	c.global_flags_string << '-$flag.short_arg'
}

// add_global_flag_bool handles adding of global flags to the command with boolean value
pub fn (mut c Commander) add_global_flag_bool(fc BoolFlagConfig) {
	// initialize new flag instance
	flag := FlagArgs{
		name: fc.name
		short_arg: fc.short_arg
		required: fc.required
		default_value: fc.default_value.str()
		data_type: .boolean
		flag_type: .global
		help: fc.help
	}

	// append to list of flags
	c.global_flags << flag
	c.global_flags_string << '--$flag.name'
	c.global_flags_string << '-$flag.short_arg'
}
