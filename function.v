module vargus

import os

// run is the main cli app executor
pub fn (mut c Commander) run() {
	// check if c is the root
	if c.is_root {
		// exclude the app from the os.args
		// the os.args[0] is the app itself, 
		c.runner(c.command, []FlagArgs{}, os.args[1..os.args.len], c.persistent_hooks)
	} else {
		println('\n [!misused] .run() can only be used on a root commander')
		exit(1)
	}
}

// runner is the helper for the `run` function
fn (c &Commander) runner(scmd string, gfls []FlagArgs, osargs []string, persistent_hooks PersistentCmdHooks) {
	mut gflags := gfls.clone()

	// append global flags
	gflags << c.global_flags

	// persistent hooks
	p_hooks := c.get_persistent_hooks(persistent_hooks)

	if osargs.len > 0 {
		// help message ([--help, -h, help] flag)
		if osargs[0] in help {
			c.help(scmd, gflags)
			exit(0)
		}

		if osargs[0] in c.sub_commands_string {
			for i in c.sub_commands {
				if i.command == osargs[0] {
					i.runner(scmd + ' $i.command', gflags, osargs[1..osargs.len], p_hooks)
					break
				}
			}
		} else {
			if !args_has_hyphen_dash(osargs[0]) && !c.allow_next_args {
				command_err(osargs[0])
			}
		}
	}
	// this will be called if nothing happened above
	args, flags := parse_flags(c, osargs, gflags)
	
	if c.exec_func {
		c.execute(c.function, args, flags, p_hooks)
	} else {
		c.help(scmd, gflags)
	}

	// exit app
	exit(0)
}

// execute is the command function runner
// it executes the function associated to the command
fn (c &Commander) execute(f fn (x []string, y []FlagArgs), args []string, flags []FlagArgs, p_hooks PersistentCmdHooks) {
	// run pre-* hooks
	if p_hooks.use_persistent_pre_run {
		p_hooks.persistent_pre_run(args, flags)
	}
	if c.hooks.use_pre_run {
		c.hooks.pre_run(args, flags)
	}

	// execute main function
	f(args, flags)

	// run post-* hooks
	if c.hooks.use_post_run {
		c.hooks.post_run(args, flags)
	}
	if p_hooks.use_persistent_post_run {
		p_hooks.persistent_post_run(args, flags)
	}
}
