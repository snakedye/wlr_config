pub fn xor(l: &str, r: &str) -> str {
	let mut str = String::new();
	let mut i:usize = 1; 
	while i <= l.len() && i <= r.len() {
		if l[i-1..i] == r[i-1..i] {
			str.push_str("0"); 			
		} else {
			str.push_str("1"); 
		}
		i += 1;
	}
	if i < r.len()+1 {
		str.push_str(&r[i-1..i]);
	}
	str
}
