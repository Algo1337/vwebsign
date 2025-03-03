import os

pub struct Nig {
	pub mut:
		name string
}

pub fn nigg() Nig {
	return Nig{"skid"}
}

fn main() {
	println(nigg().name)
}
