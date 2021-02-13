module vargus

// new creates a new commander root instance
pub fn new(cmdConfig CmdConfig) &Commander {
	t := CmdConfig{}

	return &Commander {
		command: cmdConfig.command
		short_desc: cmdConfig.short_desc
		long_desc: cmdConfig.long_desc
		allow_next_args: cmdConfig.allow_next_args
		is_root: true
		function: cmdConfig.function
		exec_func: if t.function != cmdConfig.function {
			true
		} else {
			false
		}
	}
}

// add_command adds a command to the main vargus commander instance
pub fn (mut c Commander) add_command(cmdConfig CmdConfig) &Commander {
	t := CmdConfig{}

	mut cmd := &Commander {
		command: cmdConfig.command
		short_desc: cmdConfig.short_desc
		long_desc: cmdConfig.long_desc
		allow_next_args: cmdConfig.allow_next_args
		function: cmdConfig.function
		exec_func: if t.function != cmdConfig.function {
			true
		} else {
			false
		}
	}

	// append to parent command's sub_commands
	c.sub_commands << cmd
	c.sub_commands_string << cmd.command

	// return the cmd from the sub_commands
	return c.sub_commands[c.sub_commands.index(cmd)]
}