// Generated by BUCKLESCRIPT VERSION 1.0.3 , PLEASE EDIT WITH CARE
'use strict';

var Jquery = require("./jquery");

function attributes_raw() {
  var el = Jquery.jquery("#container");
  Jquery.addClass(/* `str */[
        5744817,
        "test"
      ], el);
  el.addClass(function (_, s) {
        return s + "-list";
      });
  return /* () */0;
}

function attributes_overloaded() {
  var el = Jquery.jquery("#container");
  Jquery.attr(/* `kv */[
        23979,
        /* tuple */[
          "class",
          "foo"
        ]
      ], el);
  return /* () */0;
}

function css_test() {
  var el = Jquery.jquery("body");
  var h = Jquery.css_get$prime(/* array */[
        "height",
        "background"
      ], el);
  console.log(h);
  h.background = "lightblue";
  console.log(h);
  Jquery.css$prime(h, el);
  return /* () */0;
}

attributes_raw(/* () */0);

attributes_overloaded(/* () */0);

css_test(/* () */0);

exports.attributes_raw        = attributes_raw;
exports.attributes_overloaded = attributes_overloaded;
exports.css_test              = css_test;
/*  Not a pure module */
