module vargus

struct Vargus {
	identifier rune
}

struct Commander {
pub mut:
	add_local_flag Flagger = {
		flag_type: "local"
	}
	add_global_flag Flagger = {
		flag_type: "global"
	}
}

pub struct DefaultVarusConfig {
	identifier byte = ` `
}

// create a new instance of vargus
pub fn new(config DefaultVarusConfig) &Vargus {
	return &Vargus{
		identifier: config.identifier
	}
}

pub fn (v &Vargus) commander() &Commander {
	return &Commander{}
}

pub fn (v &Vargus) hello() string {
	return "new vargus app $v.identifier l"
}