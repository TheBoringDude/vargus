module vargus

// NOTE:
// The function below is repetitive,
// I explicitly did not combine them since it leaks pointer 
//  memory error (indirectly lost) in valgrind.

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
		config: CommandConfig {
			errors: cmdConfig.config.errors
			custom_help: cmdConfig.config.help
			use_custom_help: if t.config.help != cmdConfig.config.help {
				true
			} else {
				false
			}
			validators: ValidatorsConfig {
				integer: cmdConfig.config.validators.integer
				use_custom_integer: if t.config.validators.integer != cmdConfig.config.validators.integer {
					true
				} else {
					false
				}
				string_var: cmdConfig.config.validators.string_var
				use_custom_string_var: if t.config.validators.string_var != cmdConfig.config.validators.string_var {
					true
				} else {
					false
				}
				float: cmdConfig.config.validators.float
				use_custom_float: if t.config.validators.float != cmdConfig.config.validators.float {
					true
				} else {
					false
				}
				boolean: cmdConfig.config.validators.boolean
				use_custom_boolean: if t.config.validators.boolean != cmdConfig.config.validators.boolean {
					true
				} else {
					false
				}
			}
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
		config: CommandConfig {
			errors: cmdConfig.config.errors
			custom_help: cmdConfig.config.help
			use_custom_help: if t.config.help != cmdConfig.config.help {
				true
			} else {
				false
			}
			validators: ValidatorsConfig {
				integer: cmdConfig.config.validators.integer
				use_custom_integer: if t.config.validators.integer != cmdConfig.config.validators.integer {
					true
				} else {
					false
				}
				string_var: cmdConfig.config.validators.string_var
				use_custom_string_var: if t.config.validators.string_var != cmdConfig.config.validators.string_var {
					true
				} else {
					false
				}
				float: cmdConfig.config.validators.float
				use_custom_float: if t.config.validators.float != cmdConfig.config.validators.float {
					true
				} else {
					false
				}
				boolean: cmdConfig.config.validators.boolean
				use_custom_boolean: if t.config.validators.boolean != cmdConfig.config.validators.boolean {
					true
				} else {
					false
				}
			}
		}
	}

	// append to parent command's sub_commands
	c.sub_commands << cmd
	c.sub_commands_string << cmd.command

	// return the cmd from the sub_commands
	return c.sub_commands[c.sub_commands.index(cmd)]
}