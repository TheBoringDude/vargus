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
