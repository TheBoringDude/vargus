module vargus

// test_parse_flags is a test for vargus' flag parser
fn test_parse_flags() {
	// define custom variables
	mut c := &Commander{
		command: 'root'
	}

	c.add_local_flag_bool(
		name: 'verbose'
		short_arg: 'v'
		required: false
		default_value: false
		help: 'set to verbose'
	)

	_, test_flag := c.parse_flags(['-v', 'true'], []FlagArgs{}, CommandConfig{})

	assert test_flag[0].value == 'true'
}
