module vargus

// IntFlagConfig struct config for integer flags.
pub struct IntFlagConfig {
	name          string
	short_arg     rune
	required      bool
	default_value int
	help          string
}

// StringFlagConfig struct config for integer flags.
pub struct StringFlagConfig {
	name          string
	short_arg     rune
	required      bool
	default_value string
	help          string
}

// FloatFlagConfig struct config for integer flags.
pub struct FloatFlagConfig {
	name          string
	short_arg     rune
	required      bool
	default_value f64
	help          string
}

// BoolFlagConfig struct config for integer flags.
pub struct BoolFlagConfig {
	name          string
	short_arg     rune
	required      bool
	default_value bool
	help          string
}

type FlagsTypeConfig = BoolFlagConfig | FloatFlagConfig | IntFlagConfig | StringFlagConfig
