fn main() {

	// Generates nth first numbers
	let n = 10;

	let mut range = vec![0;n];

	for x in (1..n+1).rev() {
		range[x-1] = x;
	}

	

	for element in range.iter() {
		println!("{}", element);
	}
}
