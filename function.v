module vargus

import os

pub fn (mut c Commander) run() {
	// run flag extractor
	c.extract_flags()

	// run
	if os.args.len == 1 {
		c.root()
	} else if os.args.len > 1 {
		if os.args[1] in c.sub_commands_string {
			c.sub_command_handle(os.args[1..os.args.len])
		} else if os.args[1] in c.flags_string {
			c.root()
		}
	}
}

fn (c &Commander) sub_command_handle(osargs []string) {
	mut x := osargs.clone()

	for cmd in c.sub_commands {
		if osargs[0] == cmd.command {
			x.delete(x.index(osargs[0]))
			// println(x)

			if x.len > 0 {
				if x[0] in cmd.flags_string{
					cmd.execute(cmd.function, x)
				} else {
					cmd.sub_command_handle(x)
				}
			} else {
				cmd.execute(cmd.function, x)
			}
		}
	}
	// for j, i in c.sub_commands {
	// 	if osargs[j] == i.command {
	// 		x.delete(x.index(osargs[j]))

	// 		if x.len > 0 {
	// 			if x[1] in i.flags_string{
	// 				i.execute(i.function, x)
	// 			} else {
	// 				i.sub_command_handle(x)
	// 			}
	// 		} else {
	// 			i.execute(i.function, x)
	// 		}
	// 	}
	// }
}

// fn (mut c Commander) sub_command_handle(start int, osargs []string) {
// 	// clone the os arguments
// 	mut xos_args := osargs.clone()
// 	mut st := start
	
// 	mut x_cmder := &Commander{}

// 	// loop
// 	for mut i in c.sub_commands {
// 		if os.args[start] == i.command{
// 			for mut flag in i.flags {
// 				for arg in osargs {
// 					if arg == '--$flag.name' || arg == '--$flag.short_arg' {
// 						if flag.data_type == .boolean && (xos_args[xos_args.index(arg) + 1] != 'false' || xos_args[xos_args.index(arg) + 1] != 'true') {
// 							if flag.default_value == 'false' {
// 								flag.value = 'true'
// 							} else {
// 								flag.value = 'false'
// 							}

// 							// remove the flags from the array
// 							xos_args.delete(xos_args.index(arg))
// 						} else {
// 							match flag.data_type {
// 								.integer, .string_var, .float, .boolean {
// 									flag.value = xos_args[xos_args.index(arg) + 1]

// 									// remove the flags from the array
// 									xos_args.delete(xos_args.index(arg))
// 									xos_args.delete(xos_args.index(arg)+1)
// 								}
// 							}
// 						}
// 					}
// 				}
// 			}
// 			// append to the array
// 			i_index := c.sub_commands.index(i)
// 			c.sub_commands.delete(i_index)
// 			c.sub_commands.insert(i_index, x_cmder)

// 			// execute the function
// 			i.execute(i.function, xos_args)
// 		} else {
// 			// if not equal to sub_commands
// 			// recursive with its sub_commands
// 			i.sub_command_handle(st++, xos_args)
// 		}
// 	}
// }

fn (c &Commander) root() {
	c.execute(c.function, os.args)
}

fn (c &Commander) execute(f fn(&Commander, []string), args []string) {
	f (c, args)
}

// import os

// fn (c &Commander) execute(f fn (&Commander, []FlagArgs, []FlagArgs)) {
// 	mut tflags := c.local_flag.flags
// 	tflags << c.global_flag.flags
// 	println(tflags)
	
// 	f(c, c.local_flag.flags, c.global_flag.flags)
// }

// pub fn (v &Vargus) run() {
// 	for i in v.sub_commands {
// 		if os.args[1] == i.command {
// 			v.command_runner(v.sub_commands, 2)
// 			break
// 		}
// 	}

// 	v.root.execute(v.root.func)
// }

// fn (v &Vargus) command_runner(cmds []&Commander, start int) {
// 	mainloop: for i in cmds {
// 		if os.args[start] == i.command {
// 			i.execute(i.func)
// 		}

// 		mut fls := i.local_flag.flags
// 		fls << i.global_flag.flags

// 		for f in fls{
// 			if os.args[start] == '--$f.argument' || os.args[start] == '-$f.short_arg' {
// 				break mainloop
// 			}
// 		}

// 		v.command_runner(i.sub_commands, start+1)
// 	}
// }