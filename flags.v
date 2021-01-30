module vargus

enum FlagDataType {
	integer
	string_var
	float
	boolean
}

enum FlagType {
	local
	global
}

pub struct FlagArgs {
mut:
	name          string
	short_arg     string
	required      bool
	flag_type     FlagType
	default_value string
	data_type     FlagDataType
	help          string
	value string
}