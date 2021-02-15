module vargus

struct CommandConfig {
	use_custom_help bool
mut:
	custom_help fn (x string, y []FlagArgs, z []FlagArgs)
	errors      ErrorConfig
	validators	ValidatorsConfig
}

struct ErrorConfig {
mut:
	required string
	value    string
	blank    string
	unknown  string
	command  string
}


struct ValidatorsConfig {
	use_custom_integer bool
	use_custom_string_var bool
	use_custom_float bool
	use_custom_boolean bool
mut:
	integer fn (x string) bool
	string_var fn (x string) bool
	float fn (x string) bool
	boolean fn (x string) bool
}