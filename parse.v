module vargus

// Main PARSER
struct Parser {
mut:
	osargs map[string]string
	flag   FlagArgs
}

// MAIN PARSER, returns a string as a default
fn (p &Parser) parse() string {
	val, ok := p.find_args()

	// if ok, a value or blank val was set
	if ok {
		// check if blank
		// if it is, return the default value
		if val == '' {
			return p.flag.def_val
		}
		// else, return its value
		return val
	} else {
		check_required_err(p.flag)
	}

	// if it cannot find the value,,
	// return the default val set
	return p.flag.def_val
}

// find value set in the value
// of the defined flag
fn (p &Parser) find_args() (string, bool) {
	mut val := ''
	mut ok := false

	for arg, value in p.osargs {
		if p.flag.argument == arg || p.flag.short_arg == arg {
			val = value
			ok = true
			break
		}
	}

	return val, ok
}
