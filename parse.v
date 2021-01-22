module vargus

// Main PARSER
struct Parser {
mut:
	osargs map[string]string
}

// PARSER FOR DIFFERENT DATA TYPES
pub struct IntParser {
	Parser
	flag IntArgs
}
pub struct StringParser {
	Parser
	flag StringArgs
}
pub struct FloatParser {
	Parser
	flag FloatArgs
}


// Parser for INTEGER Values
fn (mut i IntParser) parse() int {
	// get the value of the flag
	val, ok := find_args(i.osargs, i.flag.argument, i.flag.short_arg)
	if ok {
		return val.int()
	} else {
		// if there was no value set in for the flag
		// check if it is required, (custom error)
		check_required_err(i.flag.argument, i.flag.short_arg, i.flag.required)
	}

	// if it is not required return the default value
	return i.flag.default_value
}

// Parser for STRING Values
fn (mut s StringParser) parse() string {
	// get the value of the flag
	val, ok := find_args(s.osargs, s.flag.argument, s.flag.short_arg)
	if ok {
		return val
	} else {
		// if there was no value set in for the flag
		// check if it is required, (custom error)
		check_required_err(s.flag.argument, s.flag.short_arg, s.flag.required)
	}

	// if it is not required return the default value
	return s.flag.default_value
}

// Parser for FLOAT32 Values
fn (mut f FloatParser) parse() f32 {
	// get the value of the flag
	val, ok := find_args(f.osargs, f.flag.argument, f.flag.short_arg)
	if ok {
		return val.f32()
	} else {
		// if there was no value set in for the flag
		// check if it is required, (custom error)
		check_required_err(f.flag.argument, f.flag.short_arg, f.flag.required)
	}

	// if it is not required return the default value
	return f32(f.flag.default_value)
}

// find value set in the value
// of the defined flag
fn find_args(osargs map[string]string, long_arg string, short_arg string) (string, bool) {
	mut val := ''
	mut ok := false
	
	for arg, value in osargs {
		if long_arg == arg || short_arg == arg {
			val = value
			ok = true
			break
		}
	}

	return val, ok
}