module vargus

// parse_flags is the main flag parser
// it parses all flags in the osargs
fn parse_flags(cmd &Commander, osargs []string, gflags []FlagArgs) ([]string, []FlagArgs) {
	mut flags := []FlagArgs{}
	mut args := osargs.clone()
	mut all_flags := cmd.flags.clone()

	// append
	all_flags << gflags

	// extract values
	for i in osargs {
		for c in all_flags {
			mut x := c

			if i == '--$c.name' || i == '-$c.short_arg' {
				x.value = args[args.index(i)+1]

				flags << x

				// remove from osargs
				args.delete(args.index(i)+1)
				args.delete(args.index(i))
			}
		}
	}

	return args, flags
}