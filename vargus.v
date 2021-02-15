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
	config CommandConfig
	flags               []FlagArgs
	global_flags        []FlagArgs
	global_flags_string []string
	sub_commands        []&Commander
	sub_commands_string []string
	hooks CmdHooks
	persistent_hooks PersistentCmdHooks
}

pub struct CommandCmdConfig {
	help  fn (x string, y []FlagArgs, z []FlagArgs)
	errors ErrorConfig
	validators CommandValidatorsConfig
}

pub struct CommandValidatorsConfig {
	integer fn (x string) bool
	string_var fn (x string) bool
	float fn (x string) bool
	boolean fn (x string) bool
}

pub struct CmdConfig {
	command    string
	short_desc string
	long_desc  string
	allow_next_args bool	= true // defaults to true
	function   fn (x []string, y []FlagArgs)
	config CommandCmdConfig
}
