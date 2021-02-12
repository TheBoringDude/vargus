module vargus

const (
	help = ['-h', '--help', 'help'] // help commands
)

// get_space calculates space for better spacing in print outputs
fn get_space(cmdlen int) string {
	return ' '.repeat(40-cmdlen)
}

// help prints the help info once triggered
fn (c &Commander) help(cmd_str string, gfls []FlagArgs) {
	// parse usage
	mut usage := cmd_str
	if c.sub_commands.len > 0 {
		usage += ' [command]'
	}
	if c.flags.len + gfls.len > 0 {
		usage += ' [-flags]'
	}
	// show help message
	println('\n$c.long_desc')
	println('\n Usage: $usage')

	// sub commands
	if c.sub_commands.len > 0 {
		println('\nCommands:')

		for i in c.sub_commands {
			// calculate spacing
			println('     $i.command ${get_space(i.command.len)} $i.short_desc')
		}
	}
	// local flags
	if c.flags.len > 0 {
		println('\nFlags:')

		help_print_flag(c.flags)
	}
	// global flags
	if gfls.len > 0 {
		println('\nGlobal Flags:')

		help_print_flag(gfls)
	}
}

// help_print_flag is a helper for printing flags in a cool style
fn help_print_flag(flags []FlagArgs) {
	for i in flags {
		// parse flag argument
		mut arg := ''
		if i.name != '' {
			arg += '--$i.name'
		}
		if i.short_arg != '' {
			if i.name != '' {
				arg += ', '
			}
			arg += '-$i.short_arg'
		}

		println('     $arg ${get_space(arg.len)} $i.help')
	}
}
