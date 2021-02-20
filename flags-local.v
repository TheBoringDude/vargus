module vargus

// add_local_flag_int handles adding of local flags to the command with integer value
pub fn (mut c Commander) add_local_flag_int(fc IntFlagConfig) {
	c.create_flag(fc, .local)
}

// add_local_flag_string handles adding of local flags to the command with string value
pub fn (mut c Commander) add_local_flag_string(fc StringFlagConfig) {
	c.create_flag(fc, .local)
}

// add_local_flag_float handles adding of local flags to the command with float value
pub fn (mut c Commander) add_local_flag_float(fc FloatFlagConfig) {
	c.create_flag(fc, .local)
}

// add_local_flag_bool handles adding of local flags to the command with boolean value
pub fn (mut c Commander) add_local_flag_bool(fc BoolFlagConfig) {
	c.create_flag(fc, .local)
}
