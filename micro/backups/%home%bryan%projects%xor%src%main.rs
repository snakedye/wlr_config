// use std::io;
use std::process::exit;

mod xor;
mod function;

static mut bin: [&str; 2] = ["011011","101111"];
static keys:[usize; 3] = [3,2,4];

fn main() {
	// let left = bin[1];
	// let right = round(bin[0], bin[1], &key);
	// let r = round(bin[0], bin[1], keys[n]);
	// for key in keys.iter() {
		// bin = [bin[1], &r];
	// }
	let out = feistel(0);
    println!("\nXored output: {}{}",out[0], out[1]);
}


fn round(l: &str, r: &str, n: usize) -> String {
	xor::xor(&function::rearr(l, n), r)
}

fn feistel(n:usize) -> [&'static str; 2] {
	if n == 2 {
		return bin;
	}
	let r = round(bin[0], bin[1], keys[n]);
	bin = [bin[1], &r];
	feistel(n+1)
}

fn tostring(arr:[&str;2]) -> [String;2] {
	[arr[0].to_string(),arr[0].to_string()]
}
