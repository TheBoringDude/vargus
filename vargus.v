module vargus


struct Commander {
	command    string
	short_desc string
	long_desc  string
	function   fn (x []string, y []FlagArgs)
	is_root    bool
	next_args bool
	root_config RootConfig
mut:
	exec_func bool
	flags               []FlagArgs
	global_flags        []FlagArgs
	global_flags_string []string
	sub_commands        []&Commander
	sub_commands_string []string
	hooks CmdHooks
	persistent_hooks PersistentCmdHooks
}

// TODO:
pub struct RootConfig {

}

pub struct CmdConfig {
	command    string
	short_desc string
	long_desc  string
	next_args bool	= true // defaults to true
	function   fn (x []string, y []FlagArgs)
}

pub fn new(cmdConfig CmdConfig) &Commander {
	a := CmdConfig{}

	return &Commander{
		command: cmdConfig.command
		short_desc: cmdConfig.short_desc
		long_desc: cmdConfig.long_desc
		is_root: true
		next_args: cmdConfig.next_args
		function: cmdConfig.function
		exec_func: if a.function != cmdConfig.function {
			true
		} else {
			false
		}
	}
}
