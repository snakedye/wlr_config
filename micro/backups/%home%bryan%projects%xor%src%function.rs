pub fn rearr(str: &str, n: usize) -> String {
	let mut output = String::new();
	let mut i: usize = 0;
	while output.len() < str.len() {
		let chosen = substr(&str, i, n);
		for char in chosen.chars().rev() {
			output.push_str(&char.to_string());
		}
		i+=n;
	}
	output
}

fn substr(str: &str, i: usize, n: usize) -> String {
	if str.len() < i+n {
		str[i..].to_string()		
	} else {
		str[i..i+n].to_string()		
	}
}
