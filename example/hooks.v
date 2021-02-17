// JUST AN EXAMPLE ON USING COMMAND HOOKS

import theboringdude.vargus

fn main() {
	mut command := vargus.new(
		command: 'root'
		short_desc: 'short desc'
		function: fn (args []string, flags []vargus.FlagArgs) {
			println('hi')
		}
	)

	command.add_hooks(
		hooks_type: .persistent_pre_run
		function: fn (args []string, flags []vargus.FlagArgs) {
			println('persistent pre-run : $args')
		}
	)


	// run app 
	command.run()
}