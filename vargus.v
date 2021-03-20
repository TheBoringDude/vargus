module vargus

// function type
type CmdFunction = fn (args []string, flags []FlagArgs)

// THIS IS NOT WORKING: ==> type HelpFunc = fn (a string, b string, x []HelpSubcommands, y []FlagArgs, z []FlagArgs)
type ValidatorFunc = fn (string) bool
type ErrorFuncImp = fn (string, string)
type ErrorFuncDef = fn (string)

struct Commander {
	command         string
	short_desc      string
	long_desc       string
	allow_next_args bool
mut:
	is_root             bool
	function            CmdFunction
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
	pre_run             CmdFunction
	post_run            CmdFunction
	persistent_pre_run  CmdFunction
	persistent_post_run CmdFunction
}

pub struct CmdConfig {
	command         string
	short_desc      string
	long_desc       string
	allow_next_args bool = true // defaults to true
	function        CmdFunction
	hooks           CmdHooksConfig
	config          CommandCmdConfig
}

pub struct CommandCmdConfig {
	help       fn (string, string, []HelpSubcommands, []FlagArgs, []FlagArgs)
	errors     CmdErrorsConfig
	validators CmdValidatorsConfig
}

pub struct CmdErrorsConfig {
	required ErrorFuncImp
	value    ErrorFuncImp
	blank    ErrorFuncDef
	unknown  ErrorFuncDef
	command  ErrorFuncDef
}

pub struct CmdValidatorsConfig {
	integer    ValidatorFunc
	string_var ValidatorFunc
	float      ValidatorFunc
	boolean    ValidatorFunc
}

// END STRUCTS FOR APP CLI CONFIGURATIONS
