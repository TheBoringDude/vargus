module vargus

fn args_has_hyphen_dash(a string) bool {
	if a.starts_with('-') {
		return true
	}

	return false
}