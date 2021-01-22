module vargus

struct Flagger {
	flag_type string
// mut:
// 	flags []FlagArgs
}

pub struct FlagArgs {
	argument      string [required]
	short_arg     string [required]
	required      bool   
	description   string [required]
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

type TypeArgs = IntArgs | StringArgs | FloatArgs

// handles flags with `INT` data_type
pub fn (mut fl Flagger) int(fg IntArgs) int {
	// add the flag to the []array
	// fl.flags << fg

	// arguments getter instance
	mut a := &Args{}

	// parser instance
	mut ps := &IntParser{
		flag: fg
	}
	ps.osargs = a.extract_args()

	return ps.parse()
}

// handles flags with `STRING_VAR` data_type
pub fn (mut fl Flagger) string(fg StringArgs) string {
	// add the flag to the []array
	// fl.flags << fg

	// arguments getter instance
	mut a := &Args{}

	// parser instance
	mut ps := &StringParser{
		flag: fg
	}
	ps.osargs = a.extract_args()

	return ps.parse()
}

// handles flags with `FLOAT` data_type
pub fn (mut fl Flagger) float(fg FloatArgs) f32 {
	// add the flag to the []array
	// fl.flags << fg

	// arguments getter instance
	mut a := &Args{}

	// parser instance
	mut ps := &FloatParser{
		flag: fg
	}
	ps.osargs = a.extract_args()

	return ps.parse()
}
