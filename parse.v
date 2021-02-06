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
		for ic, c in all_flags {
			mut x := c

			if i == '--$c.name' || i == '-$c.short_arg' {
				x.value = args[args.index(i)+1]

				// append new flag w/ value to flags
				flags << x

				// remove old flag w/ value from all
				all_flags.delete(ic)

				// remove from osargs
				args.delete(args.index(i)+1)
				args.delete(args.index(i))
			}
		}
	}

	
	prsd_helper_flags := parse_helper(all_flags)

	// append parsed flags from helper
	flags << prsd_helper_flags

	return args, flags
}

// parse_helper is a helper to the main parser
// it verifies values of flags and checks if they are required or not
fn parse_helper(flags []FlagArgs) []FlagArgs {
	mut fl := flags.clone()

	for mut i in fl {
		if i.value == '' {
			// if required show error
			if i.required == true {
				required_err(i.name, i.short_arg)
			}

			// otherwise, set value with default
			i.value = i.default_value
		}
	}

	return fl
}