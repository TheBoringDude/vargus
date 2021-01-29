module vargus

pub struct Commander {
	command    string
	short_desc string
	long_desc  string
	function   fn (&Commander, []string)
mut:
	flags []FlagArgs
	flags_string []string
	extracted_flags map[string]string
	sub_commands []&Commander
	sub_commands_string []string
}

pub struct CmdConfig {
	command    string
	short_desc string
	long_desc  string
	function   fn (&Commander, []string)
}

pub fn new(cmdConfig CmdConfig) &Commander {
	return &Commander{
		command: cmdConfig.command
		short_desc: cmdConfig.short_desc
		long_desc: cmdConfig.long_desc
		function: cmdConfig.function
	}
}
