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
	value         string
}

// create_flag creates a flagargs from defined flagtype
fn (mut c Commander) create_flag(fc FlagsTypeConfig, fl_type FlagType) {
	// initialize new flag instance
	mut flag := FlagArgs{}

	flag.name = fc.name
	flag.short_arg = fc.short_arg
	flag.required = fc.required
	flag.help = fc.help

	match fc {
		IntFlagConfig {
			flag.default_value = fc.default_value.str()
			flag.data_type = .integer
		}
		StringFlagConfig {
			flag.default_value = fc.default_value
			flag.data_type = .string_var
		}
		FloatFlagConfig {
			flag.default_value = fc.default_value.str()
			flag.data_type = .float
		}
		BoolFlagConfig {
			flag.default_value = fc.default_value.str()
			flag.data_type = .boolean
		}
	}

	// flag checker
	flag_checker(flag.name, flag.short_arg)

	flag.flag_type = fl_type

	// append to list of flags
	match fl_type {
		.global {
			c.global_flags.insert(c.global_flags.len, flag)
		}
		.local {
			c.flags.insert(c.flags.len, flag)
		}
	}
}

// getter gets the string value of the flag
fn getter(flags []FlagArgs, name string, dtype FlagDataType) string {
	mut temp_value := ''
	mut exists := false

	// loop, get value from flags array
	for i in flags {
		if i.name == name || i.short_arg == name {
			if i.data_type == dtype {
				temp_value = i.value
				exists = true
			} else {
				println('\n [!invalid_flag] cannot get value of flag `$name` with data_type: $dtype')
				exit(2)
			}
			break
		}
	}

	// if the flag doesn't exist,
	// show flag error
	if !exists {
		flag_err(name)
	}

	return temp_value
}

// get_int gets the value of the flag
//    name: name of flag / short_arg
pub fn (f []FlagArgs) get_int(name string) int {
	return getter(f, name, .integer).int()
}

// get_bool gets the value of the flag
//    name: name of flag / short_arg
pub fn (f []FlagArgs) get_bool(name string) bool {
	return getter(f, name, .boolean).bool()
}

// get_string gets the value of the flag
//    name: name of flag / short_arg
pub fn (f []FlagArgs) get_string(name string) string {
	return getter(f, name, .string_var)
}

// get_float gets the value of the flag
//    name: name of flag / short_arg
pub fn (f []FlagArgs) get_float(name string) f64 {
	return getter(f, name, .float).f64()
}
