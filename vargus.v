module vargus

struct Commander {
	command         string
	short_desc      string
	long_desc       string
	allow_next_args bool
mut:
	is_root             bool
	function            fn (x []string, y []FlagArgs)
	exec_func           bool
	config              CommandConfig
	flags               []FlagArgs
	global_flags        []FlagArgs
	global_flags_string []string
	sub_commands        []&Commander
	sub_commands_string []string
	hooks               CmdHooks
	persistent_hooks    PersistentCmdHooks
}

// STRUCTS FOR APP CLI CONFIGURATIONS
//   NOTE: THIS MIGHT BE REMOVED OR CHANGED IN THE FUTURE
pub struct CmdHooksConfig {
	pre_run             fn (x []string, y []FlagArgs)
	post_run            fn (x []string, y []FlagArgs)
	persistent_pre_run  fn (x []string, y []FlagArgs)
	persistent_post_run fn (x []string, y []FlagArgs)
}

pub struct CommandCmdConfig {
	help       fn (string, string, []HelpSubcommands, []FlagArgs, []FlagArgs)
	errors     CmdErrorsConfig
	validators CmdValidatorsConfig
}

pub struct CmdErrorsConfig {
	required fn (string, string)
	value    fn (string, string)
	blank    fn (string)
	unknown  fn (string)
	command  fn (string)
}

pub struct CmdValidatorsConfig {
	integer    fn (string) bool
	string_var fn (string) bool
	float      fn (string) bool
	boolean    fn (string) bool
}

pub struct CmdConfig {
	command         string
	short_desc      string
	long_desc       string
	allow_next_args bool = true // defaults to true
	function        fn (x []string, y []FlagArgs)
	hooks           CmdHooksConfig
	config          CommandCmdConfig
}

// END STRUCTS FOR APP CLI CONFIGURATIONS
