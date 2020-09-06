let currency = [['one',1], ['five',5], ['ten',10], ['twenty',20]];

let difference = 25;

let unit = currency.reduce((output,a)=>{
	if (difference == a[1]) {
		output = a;
	} else if (difference > a[1] && difference < 100) {
		output = a;
	} else if (difference >= currency.slice(-1)[1]) {
		output = currency.slice(-1);
	}
	return output;
}, ''); console.log(unit);
