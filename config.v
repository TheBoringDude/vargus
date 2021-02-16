module vargus

// CommandConfig is the default cli command custom configurations
struct CommandConfig {
mut:
	use_custom_help bool
	custom_help fn (x string, y []FlagArgs, z []FlagArgs)
	errors      ErrorConfig
	validators	ValidatorsConfig
}

// ErrorConfig is the custom configurations for error messages
struct ErrorConfig {
mut:
	use_custom_required bool
	use_custom_value bool
	use_custom_blank bool
	use_custom_unknown bool
	use_custom_command bool
	required fn (x string, y string)
	value    fn (x string, y string)
	blank    fn (x string)
	unknown  fn (x string)
	command  fn (x string)
}

// ValidatorsConfig is the custom configurations for flag validators
struct ValidatorsConfig {
mut:
	use_custom_integer bool
	use_custom_string_var bool
	use_custom_float bool
	use_custom_boolean bool
	integer fn (x string) bool
	string_var fn (x string) bool
	float fn (x string) bool
	boolean fn (x string) bool
}

// set_help sets a custom help function for the app
pub fn (mut c Commander) set_help(f fn (x string, y []FlagArgs, z []FlagArgs)) {
	c.config.custom_help = f
	c.config.use_custom_help = true
}


pub struct CFlagValidatorConfig {
	flag_type FlagDataType [required]
	function fn (x string) bool [required]
}


// set_validator sets a custom validators for a specific flag type
pub fn (mut c Commander) set_validator(cf CFlagValidatorConfig) {
	match cf.flag_type {
		.integer {
			c.config.validators.use_custom_integer = true
			c.config.validators.integer = cf.function
		}
		.string_var {
			c.config.validators.use_custom_string_var = true
			c.config.validators.string_var = cf.function
		}
		.float {
			c.config.validators.use_custom_float = true
			c.config.validators.float = cf.function
		}
		.boolean {
			c.config.validators.use_custom_boolean = true
			c.config.validators.boolean = cf.function
		}
	}
}