module vargus

struct TestCase {
	case    string
	exp_out bool
}

fn test_args_has_hyphen_dash() {
	test_cases := [
		TestCase{
			case: '-r'
			exp_out: true
		},
		TestCase{
			case: '--r'
			exp_out: true
		},
		TestCase{
			case: '---r'
			exp_out: false
		},
		TestCase{
			case: 'r'
			exp_out: false
		},
	]

	for t in test_cases {
		assert args_has_hyphen_dash(t.case) == t.exp_out
	}
}
