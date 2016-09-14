type jquery;;

external jquery : string -> jquery = "" [@@bs.module]
external jquery' : jquery -> jquery = "jquery" [@@bs.module]

external addClass : string -> jquery = "addClass" [@@bs.send.pipe: jquery]
external addClass' : (jquery -> int -> string -> string [@bs.this]) -> jquery = "addClass" [@@bs.send.pipe: jquery]
external attr : string -> string -> jquery = "attr" [@@bs.send.pipe: jquery]
external hasClass : string -> bool = "hasClass" [@@bs.send.pipe: jquery]
external html : string = "html" [@@bs.send.pipe: jquery]
external html' : string -> jquery = "html" [@@bs.send.pipe: jquery]

external prop : string -> 'a Js.t = "prop" [@@bs.send.pipe: jquery]
external prop' : string -> string -> jquery = "prop" [@@bs.send.pipe: jquery]

external css : string -> string -> jquery = "css" [@@bs.send.pipe: jquery]
external css_m : 'a Js.t -> jquery = "css" [@@bs.send.pipe: jquery]

external append : string -> jquery = "append" [@@bs.send.pipe: jquery]

let jquery = jquery;;
let addClass = addClass;;
let css = css;;

let set_attr () =
	let body = jquery "body" in
	ignore (body |> addClass "hoge");
	ignore (body |> addClass' (fun [@bs.this] o i s ->
		Js.log o;
		Js.log (jquery' o);
		s
	));
	Js.log @@ string_of_bool (body |> hasClass "hoge");
	Js.log (body |> html);
	Js.log (body |> html' "hoge");
	Js.log (body |> html);
	let div = body |> append "<div>Hey</div>" in
	let _ = body |> css_m [%bs.obj {background = "pink"; width = "100px"}] in
	let _ = div |> attr "id" "test" |> css "color" "red" in
	print_endline "Done";;

