var BigInteger = require("big-integer");
	var tenToTheTen = BigInteger("10000000000");

// return the last ten digits of x^power

// 1st thing to do: write the binary expansion of the power pow
// 2nd thing to do: write a function that computes x^(2^k) modulo 1000000000 for each k
// by repeated squaring
function fastExpLastDigits(x, power) {
	var i; var numDigitsPower = Math.floor(Math.log(power)  / Math.log(2)) + 1;

	var binaryExpansion = computeBinaryExpansion(power, numDigitsPower); // an array that contains the binary expansion of power
	var result = BigInteger(1); fastExpPowerOfTwo = BigInteger(x); // x^1
	for (i = 0; i < numDigitsPower; i++) {
		if (binaryExpansion[i] == 1) {
			result = result.multiply(fastExpPowerOfTwo).remainder(tenToTheTen);
		}
		fastExpPowerOfTwo = fastExpPowerOfTwo.multiply(fastExpPowerOfTwo);
		// console.log(fastExpPowerOfTwo);
	}
	return result;
}

function computeBinaryExpansion(x, numDigits) {
	var i; var twoToTheI = 1; var result = Array();
	for (i = 0; i < numDigits; i++) {
		result[i] = x % 2;
		x = Math.floor(x / 2);
	}
	return result;
}

function computeProblemFunction(k) {
	var i; var result = BigInteger(0);
	for (i = 1; i <= k; i++) {
		result = result.add(fastExpLastDigits(i, i)).remainder(tenToTheTen);
	}
	return result; 
}

console.log("Hello, world!");
console.log(computeProblemFunction(1000).toJSNumber());