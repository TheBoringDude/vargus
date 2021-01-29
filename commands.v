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

// // Add functions on root CLI call
// // This is where the root parser goes
// pub fn (mut v Vargus) root() &Commander {
// 	v.root = &Commander{
// 		command: '',
// 		local_flag: {
// 			flag_type: 'local'
// 		},
// 		global_flag: {
// 			flag_type: 'global'
// 		},
// 	}

// 	return v.root
// }

// // Add new CLI Command
// pub fn (mut v Vargus) add_command(func fn(&Commander, []FlagArgs, []FlagArgs), cmd string) &Commander {
// 	// validate arguments
// 	if cmd == '' {
// 		println('  [!err] cannot add blank command')
// 		exit(0)
// 	}

// 	// create commander instance
// 	command := &Commander {
// 		command: cmd,
// 		func: func,
// 		local_flag:{
// 			flag_type: 'local'
// 			command: cmd
// 		},
// 		global_flag:{
// 			flag_type: 'global'
// 			command: cmd
// 		},
// 	}

// 	v.sub_commands << command

// 	return command
// }

// // Add Sub Command
// pub fn (mut v Vargus) add_sub_command(func fn(&Commander, []FlagArgs, []FlagArgs), command &Commander, cmd string) &Commander {
// 	// convert commander to mutable
// 	mut c := command

// 	// validate arguments
// 	if cmd == '' {
// 		println('  [!err] cannot add blank command')
// 		exit(0)
// 	}
// 	if command == v.root {
// 		println('  [!err] incorrect use of `add_sub_command`')
// 		exit(0)
// 	}

// 	// create commander instance
// 	sub := &Commander {
// 		command: cmd,
// 		func: func,
// 		local_flag:{
// 			flag_type: 'local'
// 			command: cmd
// 		},
// 		global_flag:{
// 			flag_type: 'global'
// 			command: cmd
// 		},
// 	}

// 	c.sub_commands << sub
	
// 	// replace old command with new
// 	// command w/ sub_commands
// 	mut p := v.check_command_parent(v.sub_commands, command)

// 	if p.len > 0 {
// 		p.delete(p.index(command))
// 		p << c
// 	}

// 	return c.sub_commands[c.sub_commands.index(sub)]
// }

// // Checks the parent command and returns it
// fn (v &Vargus) check_command_parent(commands []&Commander, cmd &Commander) []&Commander {
// 	if cmd in commands {
// 		return commands
// 	}

// 	for i in commands {
// 		v.check_command_parent(i.sub_commands, cmd)
// 	}

// 	// return blank
// 	return []&Commander{}
// } 

// pub fn (fl FlagArgs) get_int_value() int{
// 	return fl.value.int()
// } 