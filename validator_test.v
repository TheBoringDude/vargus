module vargus

// TEST CASES FOR INT_VALIDATOR
fn test_int_validator_basic() {
	x := '1'
	assert int_validator(x) == true
}
fn test_int_validator_negative() {
	x := '-1'
	assert int_validator(x) == true
}
fn test_int_validator_mis1() {
	x := '-1.0'
	assert int_validator(x) == false
}
fn test_int_validator_mis2() {
	x := '1-0'
	assert int_validator(x) == false
}
// TEST CASES FOR INT_VALIDATOR

// TEST CASES FOR FLOAT_VALIDATOR
fn test_float_validator_basic() {
	x := '1.0'
	assert float_validator(x) == true
}
fn test_float_validator_negative() {
	x := '-1.0'
	assert float_validator(x) == true
}
fn test_float_validator_mis1() {
	x := '-1..0'
	assert float_validator(x) == false
}
fn test_float_validator_mis2() {
	x := '1.-0'
	assert float_validator(x) == false
}
// TEST CASES FOR FLOAT_VALIDATOR