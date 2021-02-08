module vargus

struct Commander {
	command    string
	short_desc string
	long_desc  string
	function   fn (args []string, flags []FlagArgs)
	is_root bool
mut:
	flags []FlagArgs
	global_flags []FlagArgs
	local_flags_string []string
	global_flags_string []string
	extracted_flags map[string]string
	sub_commands []&Commander
	sub_commands_string []string
}

pub struct CmdConfig {
	command    string
	short_desc string
	long_desc  string
	function   fn (args []string, flags []FlagArgs)
}

pub fn new(cmdConfig CmdConfig) &Commander {
	return &Commander{
		command: cmdConfig.command
		short_desc: cmdConfig.short_desc
		long_desc: cmdConfig.long_desc
		function: cmdConfig.function
		is_root: true
	}
}
