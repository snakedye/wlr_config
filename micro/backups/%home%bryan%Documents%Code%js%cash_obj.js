function checkCashRegister(price, cash, cid) {
	var currency = {
	  "PENNY": 1,
	  "NICKEL": 5,
	  "DIME": 10,
	  "QUARTER": 25,
	  "ONE": 100,
	  "FIVE": 500,
	  "TEN": 1000,
	  "TWENTY": 2000,
	  "ONE HUNDRED": 10000
	};
	var og_cid = cid.reduce((obj, prop) => {
		obj[prop[0]] = Math.round(prop[1] * 100);
		return obj;
	}, {});
	var arr_cid = cid;
	cid = cid.reduce((obj, prop) => {
		obj[prop[0]] = Math.round(prop[1] * 100);
		return obj;
	}, {}); // console.log(cid);
	
	var status; var change = []; var difference = (cash * 100 - price * 100); var dd = difference;
	if (difference < 0) {
		status = "INSUFFICIENT_FUNDS";
		change = [];
	}
	while (difference >= 0) {
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
	}, 0)]); // console.log(change)
	if (change.reduce((a,b)=>a+b[1],0) === dd) {
		status = "OPEN";
		// console.log(change);
		// console.log(arr_cid);
		if (change.reverse().every(a => a[1] == og_cid[a[0]])) {
			status = "CLOSED";
			change = arr_cid;
		} else {
			change = change.filter(a => a[1] != 0).map(a => [a[0], a[1]/100]);
		}
		
	} else {
		status = "INSUFFICIENT_FUNDS",
		change = [];
	}
	
	return {
		status: status,
		change: change,
	}
}
console.log(
checkCashRegister(19.5, 20, [["PENNY", 0.5], ["NICKEL", 0], ["DIME", 0], ["QUARTER", 0], ["ONE", 0], ["FIVE", 0], ["TEN", 0], ["TWENTY", 0], ["ONE HUNDRED", 0]])
)
