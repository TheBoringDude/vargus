module vargus


struct Vargus {
	identifier rune
mut:
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
	return &Commander{
		add_local_flag: {
			flag_type: 'local'
		},
		add_global_flag: {
			flag_type: 'global'
		},
	}
}

// Add new CLI Command
pub fn (mut v Vargus) add_command(cmd string) &Commander {
	// c.commands << Command{
	// 	command: cmd,
	// }
	command := &Commander {
		command: cmd,
		add_local_flag:{
			flag_type: 'local'
			command: cmd
		},
		add_global_flag:{
			flag_type: 'global'
			command: cmd
		},
	}

	v.sub_commands << command

	return command
}

// Checks the parent command and returns it
fn (v &Vargus) check_command_parent(commands []&Commander, cmd &Commander) []&Commander {
	if cmd in commands {
		return commands
	}

	for i in commands {
		v.check_command_parent(i.sub_commands, cmd)
	}

	// return blank
	return []&Commander{}
}

// Add Sub Command
pub fn (mut v Vargus) add_sub_command(command &Commander, cmd string) &Commander {
	mut c := command

	sub := &Commander {
		command: cmd,
		under: c.command,
		add_local_flag:{
			flag_type: 'local'
			command: cmd
		},
		add_global_flag:{
			flag_type: 'global'
			command: cmd
		},
	}

	c.sub_commands << sub
	
	// replace old command with new
	// command w/ sub_commands
	mut p := v.check_command_parent(v.sub_commands, command)

	if p.len > 0 {
		p.delete(p.index(command))
		p << c
	}

	return c.sub_commands[c.sub_commands.index(sub)]
}

// Returns usage of the CLI App
pub fn (v &Vargus) usage() []&Commander {
	return v.sub_commands
}

pub fn (v &Vargus) hello() string {
	return 'new vargus app $v.identifier l'
}
