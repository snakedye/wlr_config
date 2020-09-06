function checkCashRegister(price, cash, cid) {
	var currency = {
	  "PENNY": 0.01,
	  "NICKEL": 0.05,
	  "DIME": 0.10,
	  "QUARTER": 0.25,
	  "ONE": 1,
	  "FIVE": 5,
	  "TEN": 10,
	  "TWENTY": 20,
	  "ONE HUNDRED": 100
	};
	var og_cid = cid;
	cid = cid.reduce((obj, prop) => {
		obj[prop[0]] = prop[1];
		return obj;
	}, {}); // console.log(cid);
	var status; var change = []; var total = 0; var difference = (cash - price);
	if (difference < 0) {
		status = "INSUFFICIENT_FUNDS";
		change = [];
	}
	while (difference > 0) {
		var unit = Object.keys(currency).reverse().reduce((output,prop)=>{
			if (difference >= currency[prop] && cid[prop] >= currency[prop]) {
				output.push(prop, currency[prop]);
			} else {}
			return output;
		}, []);
		cid[unit[0]] -= unit[1];
		difference -= unit[1];
		change.push(unit);
	} //  console.log(change);
	change = Object.keys(currency).map(unit => [unit, change.reduce((a,coin)=> {
		if (coin[0] === unit) {
			return a += coin[1];
		}
		return a;
	}, 0)]); // console.log(change);
	if (og_cid.every(a => a[1] >= 0)) {
		status = "OPEN";
		if (change == og_cid) {
		status = "CLOSED";
		}
		change = change.filter(a => a[1] != 0).reverse();
		if (change.slice(-1)[0][1] > 0) {
			change.slice(-1)[0][1] += 0.01;
		}
	} else {
		status = "INSUFFICIENT_FUNDS",
		change = []
	}
	return {
		status: status,
		change: change,
	}
}
console.log(
checkCashRegister(95.7, 100, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.1], ["QUARTER", 4.25], ["ONE", 90], ["FIVE", 55], ["TEN", 20], ["TWENTY", 60], ["ONE HUNDRED", 100]])
)
