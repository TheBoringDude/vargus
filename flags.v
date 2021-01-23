module vargus

struct Flagger {
	flag_type string
mut:
	a     Args
	flags []FlagArgs
}

pub struct FlagArgs {
	argument    string [required]
	short_arg   string [required]
	required    bool
	description string [required]
mut:
	def_val string // this should not be public [todo: make it private]
}

pub struct IntArgs {
	FlagArgs
	default_value int
}

pub struct StringArgs {
	FlagArgs
	default_value string
}

pub struct FloatArgs {
	FlagArgs
	default_value f32
}

type TypeArgs = FloatArgs | IntArgs | StringArgs

// Creates a parser instance
fn (mut fl Flagger) create_parser(flag FlagArgs) &Parser {
	return &Parser{
		osargs: fl.a.extract_args()
		flag: flag
	}
}

// Appends the flag to the array for help usages
// -> Converts the default value set to string
//    this is for convenience for the array
// -> Return a new FlagArgs with the def_val
//    as string converted from the parsed default_value
fn (mut fl Flagger) appender(flag TypeArgs) FlagArgs {
	// append the flag to the array `flags`
	// TODO: shorten this code, it's repetitive
	match flag {
		IntArgs {
			mut gf := flag
			gf.def_val = flag.default_value.str()
			fl.flags << gf.FlagArgs
			return gf.FlagArgs
		}
		StringArgs {
			mut gf := flag
			gf.def_val = flag.default_value
			fl.flags << gf.FlagArgs
			return gf.FlagArgs
		}
		FloatArgs {
			mut gf := flag
			gf.def_val = flag.default_value.str()
			fl.flags << gf.FlagArgs
			return gf.FlagArgs
		}
	}
}

// Handles flags with `INT` data_type
pub fn (mut fl Flagger) int(fg IntArgs) int {
	// append the flag
	gf := fl.appender(fg)
	// create parser
	ps := fl.create_parser(gf)
	// return the value
	return ps.parse().int()
}

// Handles flags with `STRING_VAR` data_type
pub fn (mut fl Flagger) string(fg StringArgs) string {
	// append the flag
	gf := fl.appender(fg)
	// create parser
	ps := fl.create_parser(gf)
	// return the value
	return ps.parse()
}

// Handles flags with `FLOAT` data_type
pub fn (mut fl Flagger) float(fg FloatArgs) f32 {
	// append the flag
	gf := fl.appender(fg)
	// create parser
	ps := fl.create_parser(gf)
	// return the value
	return ps.parse().f32()
}
