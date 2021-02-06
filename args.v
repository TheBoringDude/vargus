module vargus

fn args_has_hyphen_dash(a string) bool {
	if a.starts_with('-') {
		if a.count('-') <= 2 {
			return true
		}
	}

	return false
}