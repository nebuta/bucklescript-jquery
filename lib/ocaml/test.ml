open Jquery;;

external js_assert : Js.boolean -> unit = "assert" [@@bs.val]

let attributes_raw () =
	let el = jquery "#container" in
	ignore (el |> addClass (`str "test"));
	ignore (el |> addClass' (fun [@bs.this] jq i s  -> s^"-list"));
	();;

let attributes_overloaded () =
	let el = jquery "#container" in
	ignore (el |> attr (`kv ("class","foo")));
	();;


let css_test () =
	let el = jquery "body" in
	let h = el |> css_get' [|"height"; "background"|] in
	Js.log h;
	h##background #= "lightblue";
	Js.log h;
	el |> css' h;
	();; 

let () =
	attributes_raw ();
	attributes_overloaded ();
	append_test ();
	css_test ();;
