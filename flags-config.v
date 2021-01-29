module vargus

pub struct IntFlagConfig {
	name string
	short_arg string
	required bool
	default_value int
	help string
}

pub struct StringFlagConfig {
	name string
	short_arg string
	required bool
	default_value string
	help string
}

pub struct FloatFlagConfig {
	name string
	short_arg string
	required bool
	default_value f32
	help string
}

pub struct BoolFlagConfig {
	name string
	short_arg string
	required bool
	default_value bool
	help string
}