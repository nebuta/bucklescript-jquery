open Jquery;;

external js_assert : Js.boolean -> unit = "assert" [@@bs.val]

let attributes_raw () =
	let el = jquery "#container" in
	ignore (el |> addClass "test");
	ignore (el |> addClass' (fun [@bs.this] jq i s  -> s^"-list"));
	();;

let attributes_overloaded () =
	let el = jquery "#container" in
	ignore (el |> attr (Str ("class","foo")));
	();;

let () =
	attributes_raw ();
	attributes_overloaded ();;
