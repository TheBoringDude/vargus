module vargus

import os

pub fn (mut c Commander) run() {
	// run flag extractor
	// c.extract_flags()

	// run
	if os.args.len == 1 {
		c.root()
	} else if os.args.len > 1 {
		if os.args[1] in c.sub_commands_string || os.args[1].replace('-', '') in c.global_flags_string {
			os_args, gflags := get_global_flags(c, os.args[1..os.args.len])
			
			c.sub_command_handle(gflags, os_args)
		} else if os.args[1] in c.local_flags_string {
			c.root()
		} else {
			if args_has_hyphen_dash(os.args[1]) && (os.args[1].replace('-','') in c.global_flags_string) == false {
				println('\n  [!err] unknown flag ${os.args[1]} kk')
				exit(1)
			}
		}
	}
}

fn (c &Commander) sub_command_handle(g_flags []FlagArgs, osargs []string) {
	mut x := osargs.clone()

	// global flags
	mut total_flags := []FlagArgs{}

	total_flags << g_flags

	for cmd in c.sub_commands {
		if osargs[0] == cmd.command {
			x.delete(x.index(osargs[0]))

			if x.len > 0 {
				args, gfls := get_global_flags(cmd, x)

				total_flags << gfls

				// check if the next arg is in it's subcommands
				if args.len > 0 {
					if args[0] in cmd.sub_commands_string{
						cmd.sub_command_handle(total_flags, args)
					}

					// otherwise, execute the command itself
					else {
						args2, flags := parse_flags(cmd, args)
						total_flags << flags

						cmd.execute(cmd.function, args2, total_flags)
					}
				}
				// otherwise, execute the command itself
				else {
					args2, flags := parse_flags(cmd, args)
					total_flags << flags

					cmd.execute(cmd.function, args2, total_flags)
				}
			} else {
				args, flags := parse_flags(cmd, x)
				total_flags << flags
				cmd.execute(cmd.function, args, total_flags)
			}
		}
	}
}

fn (c &Commander) root() {
	args, flags := parse_flags(c, os.args)

	c.execute(c.function, args, flags)
}

fn (c &Commander) execute(f fn(&Commander, []string, []FlagArgs), args []string, flags []FlagArgs) {
	f (c, args, flags)
}