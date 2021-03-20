module main

import theboringdude.vargus

fn handler(args []string) {
}

fn main() {
	root := vargus.CmdConfig{
		command: 'root'
		short_desc: 'short desc'
		long_desc: 'some long description'
		function: fn (args []string, flags []vargus.FlagArgs) {
			println('hi')
			println(args)
			println(flags.get_int('one'))
		}
	}

	mut cmder := vargus.new(root)

	cmder.add_hooks(
		hooks_type: .persistent_pre_run
		function: fn (args []string, flags []vargus.FlagArgs) {
			println('persistent pre-run : $args')
		}
	)
	cmder.add_hooks(
		hooks_type: .pre_run
		function: fn (args []string, flags []vargus.FlagArgs) {
			println('pre-run : $args')
		}
	)

	mut generate := cmder.add_command(
		command: 'generate'
		short_desc: 'generate  desc'
		long_desc: 'generate some long description'
		function: fn (args []string, flags []vargus.FlagArgs) {
			println(args)
			println('generator')
			println(flags.get_bool('verbose'))
		}
	)

	generate.add_hooks(
		hooks_type: .persistent_pre_run
		function: fn (args []string, flags []vargus.FlagArgs) {
			println('generate - persistent pre-run : $args')
		}
	)

	cmder.add_command(
		command: 'gen'
		short_desc: 'generate  desc'
		long_desc: 'generate some long description'
		function: fn (args []string, flags []vargus.FlagArgs) {
			println(args)
			println('generator')
			println(flags.get_bool('verbose'))
		}
	)

	mut project := generate.add_command(
		command: 'project'
		short_desc: 'project  desc'
		long_desc: 'project some long description'
		function: fn (args []string, flags []vargus.FlagArgs) {
			println('generate project')
			println(args)
			println(flags)
		}
	)

	project.add_command(
		command: 'klop'
		short_desc: 'project  desc'
		long_desc: 'project some long description'
		function: fn (args []string, flags []vargus.FlagArgs) {
			println(args)
			println(flags)
			println('klop')
		}
	)

	cmder.add_global_flag_int(
		name: 'one'
		short_arg: `o`
		required: false
		default_value: 1
		help: 'oooo'
	)
	generate.add_global_flag_string(
		name: 'type'
		short_arg: `t`
		required: false
		default_value: 'll'
		help: 'project dir'
	)
	generate.add_global_flag_bool(
		name: 'verbose'
		short_arg: `v`
		required: false
		default_value: false
		help: 'set to verbose'
	)
	project.add_local_flag_string(
		name: 'dir'
		short_arg: `d`
		required: true
		default_value: ''
		help: 'project dir'
	)

	// println(project)

	// run app
	cmder.run()

	// cmder.help()
	// println(root)
}
