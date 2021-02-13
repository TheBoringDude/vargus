module vargus


struct Commander {
	command    string
	short_desc string
	long_desc  string
	allow_next_args bool
mut:
	is_root    bool
	function   fn (x []string, y []FlagArgs)
	exec_func bool
	root_config RootConfig
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
	allow_next_args bool	= true // defaults to true
	function   fn (x []string, y []FlagArgs)
}
