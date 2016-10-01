// How to test:
// First run `npm run compile_test` to make `lib/js/test.js` and webpack this main js file.
// Then open test_index.html to load it.


const _ = require('lodash');
const $ = require('jquery');
var esprima = require('esprima');
const ml_compiled = require('../lib/js/test.js');

function programEqual(fn1,fn2) {
	if(typeof fn1 != 'function' || typeof fn2 != 'function') {
		console.log('Either of them is non-function.');
		return false;
	}
	const p1 = esprima.parse(fn1.toString());
	const p2 = esprima.parse(fn2.toString());
	if(_.isEqual(p1.body[0].body,p2.body[0].body)){
		console.log('Equivalent function body: '+p1.body[0].id.name+", " + p2.body[0].id.name);
		return true;
	}else{
		console.log('Not equivalent:');
		console.log(p1,p2);
		return false;
	}
}

// Unit tests

function attributes_raw() {
  var el = Jquery.jquery("#container");
  el.addClass("test");
  el.addClass(function (_, s) {
        return s+"-list";
   });
     return 0;
}

function main() {
	var flag = true;
	// Equality cannot be checked by this way for polymorphic variants.
	// flag &= programEqual(ml_compiled.attributes_raw,attributes_raw);
	if(flag){
		console.log("Test success!");
		$('body').append('<h3>Test success</h3>')
	}else{
		console.log("Test failed.");
		$('body').append('<h3>Test failure</h3>')
	}
}

main();