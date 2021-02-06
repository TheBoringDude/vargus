module vargus

// add_command adds a command to the main vargus commander instance
pub fn (mut c Commander) add_command(cmdConfig CmdConfig) &Commander {
	// create new commander instance
	cmd := &Commander {
		command: cmdConfig.command,
		short_desc: cmdConfig.short_desc,
		long_desc: cmdConfig.long_desc,
		function: cmdConfig.function,
	}

	// append to parent command's sub_commands
	c.sub_commands << cmd
	c.sub_commands_string << cmd.command

	// return the cmd from the sub_commands
	return c.sub_commands[c.sub_commands.index(cmd)]
}
