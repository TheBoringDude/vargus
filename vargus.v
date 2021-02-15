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

// STRUCTS FOR APP CLI CONFIGURATIONS
pub struct CmdHooksConfig {
	pre_run fn (x []string, y []FlagArgs)
	post_run fn (x []string, y []FlagArgs)
	persistent_pre_run fn (x []string, y []FlagArgs)
	persistent_post_run fn (x []string, y []FlagArgs)
}

pub struct CommandCmdConfig {
	help  fn (x string, y []FlagArgs, z []FlagArgs)
	errors CmdErrorsConfig
	validators CmdValidatorsConfig
}

pub struct CmdErrorsConfig {
	required fn (x string, y string)
	value    fn (x string, y string)
	blank    fn (x string)
	unknown  fn (x string)
	command  fn (x string)
}

pub struct CmdValidatorsConfig {
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
	hooks CmdHooksConfig
	config CommandCmdConfig
}
// END STRUCTS FOR APP CLI CONFIGURATIONS