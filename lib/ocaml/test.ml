open Jquery;;

external js_assert : Js.boolean -> unit = "assert" [@@bs.val]

let testAttributes () =
	let el = jquery "#container" in
	ignore (el |> addClass "test");
	ignore (el |> addClass' (fun [@bs.this] jq i s  -> s^"-list"));;

let () =
	testAttributes ();;
