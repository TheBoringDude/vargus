module vargus

import os

// run is the main cli app executor
pub fn (mut c Commander) run() {
	// check if c is the root
	if c.is_root {
		// exclude the app from the os.args
		// the os.args[0] is the app itself, 
		c.runner(c.command, []FlagArgs{}, os.args[1..os.args.len], PersistentCmdHooks{},
			c.config)
	} else {
		println('\n [!misused] .run() can only be used on a root commander')
		exit(1)
	}
}

// runner is the helper for the `run` function
//	scmd => string command
fn (c &Commander) runner(scmd string, gfls []FlagArgs, osargs []string, persistent_hooks PersistentCmdHooks, p_config CommandConfig) {
	mut gflags := gfls.clone()

	// append global flags
	gflags << c.global_flags

	// persistent hooks
	p_hooks := c.get_persistent_hooks(persistent_hooks)

	// parse configurations
	cfg := c.parse_config(p_config)

	// CMD HELP VARIABLES
	mut cmd_help := scmd
	mut cmd_desc := c.long_desc
	mut cmd_flags := c.flags.clone()
	mut cmd_gflags := gflags.clone()
	mut cmd_subcommands := parse_subcommands(c.sub_commands) // get, parse sub_commands

	if osargs.len > 0 {
		// help message ([--help, -h, help] flag)
		if osargs[0] in help {
			if osargs.len > 1 {
				for i in c.sub_commands {
					if osargs[1] == i.command {
						cmd_help += ' $i.command'
						cmd_desc = i.long_desc
						cmd_flags = i.flags.clone()
						cmd_gflags << i.global_flags
						cmd_subcommands = parse_subcommands(i.sub_commands)
						break
					}
				}
			}

			if cfg.use_custom_help {
				cfg.custom_help(cmd_help, cmd_desc, cmd_subcommands, cmd_flags, cmd_gflags)
			} else {
				c.help(cmd_help, cmd_desc, cmd_subcommands, cmd_flags, cmd_gflags)
			}
			exit(0)
		}

		if osargs[0] in c.sub_commands_string {
			for i in c.sub_commands {
				if i.command == osargs[0] {
					i.runner(scmd + ' $i.command', gflags, osargs[1..osargs.len], p_hooks,
						cfg)
					break
				}
			}
		} else {
			if !args_has_hyphen_dash(osargs[0]) && !c.allow_next_args {
				if osargs.len > 1 {
					if args_has_hyphen_dash(osargs[1]) {
						if cfg.errors.use_custom_command {
							cfg.errors.command(osargs[0])
						} else {
							c.command_err(osargs[0])
						}
						exit(1)
					}
				}
			}
		}
	}
	// this will be called if nothing happened above
	args, flags := c.parse_flags(osargs, gflags, cfg)

	if c.exec_func {
		c.execute(args, flags, p_hooks)
	} else {
		if cfg.use_custom_help {
			cfg.custom_help(cmd_help, cmd_desc, cmd_subcommands, cmd_flags, cmd_gflags)
		} else {
			c.help(cmd_help, cmd_desc, cmd_subcommands, cmd_flags, cmd_gflags)
		}
	}

	// exit app
	exit(0)
}

// execute is the command function runner
// it executes the function associated to the command
fn (c &Commander) execute(args []string, flags []FlagArgs, p_hooks PersistentCmdHooks) {
	// run pre-* hooks
	if p_hooks.use_persistent_pre_run {
		p_hooks.persistent_pre_run(args, flags)
	}
	if c.hooks.use_pre_run {
		c.hooks.pre_run(args, flags)
	}
	// execute main function
	c.function(args, flags)

	// run post-* hooks
	if c.hooks.use_post_run {
		c.hooks.post_run(args, flags)
	}
	if p_hooks.use_persistent_post_run {
		p_hooks.persistent_post_run(args, flags)
	}
}
