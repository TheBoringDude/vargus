module vargus

const (
	help = ['-h', '--help', 'help'] // help commands
)

// get_space calculates space for better spacing in print outputs
fn get_space(cmdlen int) string {
	mut space := ''
	for _ in 0 .. 40 - cmdlen {
		space += ' '
	}

	return space
}

pub fn (c &Commander) help(cmd_str string, gfls []FlagArgs) {
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
	println('\n   usage: $usage')

	// sub commands
	if c.sub_commands.len > 0 {
		println('\n Commands:')

		for i in c.sub_commands {
			// calculate spacing
			println('     $i.command ${get_space(i.command.len)} $i.short_desc')
		}
	}
	

	// local flags
	if c.flags.len > 0 {
		println('\n Flags:')

		for i in c.flags {
			// parse flag argument
			mut arg := ''
			if i.name != '' {
				arg += '--$i.name'
			}
			if i.short_arg != '' {
				if i.name != ''{
					arg += ', '
				}
				arg += '-$i.short_arg'
			}
			
			println('     $arg ${get_space(arg.len)} $i.help')
		}
	}


	// global flags
	if gfls.len > 0 {
		println('\n Global Flags:')

		for i in gfls {
			// parse flag argument
			mut arg := ''
			if i.name != '' {
				arg += '--$i.name'
			}
			if i.short_arg != '' {
				if i.name != ''{
					arg += ', '
				}
				arg += '-$i.short_arg'
			}
			
			println('     $arg ${get_space(arg.len)} $i.help')
		}
	}
}