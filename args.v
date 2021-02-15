module vargus

fn args_has_hyphen_dash(a string) bool {
	if a.starts_with('-') {
		if a.count('-') <= 2 {
			return true
		}
	}

	return false
}

// validate_final_args checks the args for a final one
//   this is a final validation, so any args with '-' or '--'
//   will be considered as unknown
fn (c &Commander) validate_final_args(args []string) {
	for i in args {
		if args_has_hyphen_dash(i) {
			c.unknown_err(i)
		}
	}
}
