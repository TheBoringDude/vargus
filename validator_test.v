module vargus

struct TestCase {
	case    string
	exp_out bool
}

// TEST CASES FOR INT_VALIDATOR
fn test_int_validator() {
	test_cases := [
		TestCase{
			case: '1'
			exp_out: true
		},
		TestCase{
			case: '-1'
			exp_out: true
		},
		TestCase{
			case: '-1.0'
			exp_out: false
		},
		TestCase{
			case: '1-0'
			exp_out: false
		},
	]

	for t in test_cases {
		assert int_validator(t.case) == t.exp_out
	}
}

// TEST CASES FOR INT_VALIDATOR

// TEST CASES FOR FLOAT_VALIDATOR
fn test_float_validator_basic() {
	test_cases := [
		TestCase{
			case: '1.0'
			exp_out: true
		},
		TestCase{
			case: '-1.0'
			exp_out: true
		},
		TestCase{
			case: '-1..0'
			exp_out: false
		},
		TestCase{
			case: '1.-0'
			exp_out: false
		},
		// // TODO: THIS WILL BE RE-IMPLEMENTED
		// TestCase{
		// case: '1e9'
		// exp_out: true
		// },
		// TestCase{
		// case: '1-e9'
		// exp_out: false
		// },
		// TestCase{
		// case: '1e-9'
		// exp_out: true
		// },
		// TestCase{
		// case: '-1.0-e-9'
		// exp_out: false
		// },
	]

	for t in test_cases {
		assert float_validator(t.case) == t.exp_out
	}
}
