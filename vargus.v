module vargus


struct Vargus {
	identifier rune
mut:
	root &Commander
	sub_commands []&Commander
}

struct Commander {
mut:
	command string
	under string
	sub_commands []&Commander
pub mut:
	add_local_flag Flagger
	add_global_flag Flagger
}

// create a new instance of vargus
pub fn new() &Vargus {
	return &Vargus{
		root: &Commander{}
	}
}

// Returns usage of the CLI App
pub fn (v &Vargus) usage() []&Commander {
	println(v.root)
	return v.sub_commands
}

pub fn (v &Vargus) hello() string {
	return 'new vargus app $v.identifier l'
}
