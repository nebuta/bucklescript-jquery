type jquery;;
type event;;
type stub;;

type ('a,'b) attr_func = jquery -> int -> 'a -> 'b [@bs.this];;
type attr_func_str = (string,string) attr_func;;
type js_coord = < top : int ; left : int > Js.t

type t;;
external jquery : string -> jquery = "" [@@bs.module]
external jquery_ : jquery =  "jquery" [@@bs.module]
external jquery' : jquery -> jquery = "jquery" [@@bs.module]

(* Attributes *)
external addClass : string -> jquery = "addClass" [@@bs.send.pipe: jquery]
external addClass' : (string,string) attr_func -> jquery = "addClass" [@@bs.send.pipe: jquery]
let addClass at jq =
	match at with
		`str s -> addClass s jq
		| `func f -> addClass' f jq;;

external attr_get : string -> string = "attr" [@@bs.send.pipe: jquery]
let attr_get = attr_get;;

external attr : string -> string -> jquery = "attr" [@@bs.send.pipe: jquery]
external attr_ : 'a Js.t -> jquery = "attr" [@@bs.send.pipe: jquery]
external attr' : (string,string) attr_func -> jquery = "attr" [@@bs.send.pipe: jquery]

let attr at (jq : jquery) : jquery =
	match at with
		`kv (k,v) -> attr k v jq;
		| `map obj -> attr_ obj jq
		| `func f -> attr' f jq;;


external hasClass : string -> Js.boolean = "hasClass" [@@bs.send.pipe: jquery]
let hasClass = hasClass;;

external html_get : string = "html" [@@bs.send.pipe: jquery]
external html : string -> jquery = "html" [@@bs.send.pipe: jquery]
external html' : (string,string) attr_func -> jquery = "html" [@@bs.send.pipe: jquery]

let html_get = html_get;;
let html at (jq : jquery) : jquery =
	match at with
		`str s -> html s jq;
		| `func f -> html' f jq;;


external prop_get : string -> 'a Js.t = "prop" [@@bs.send.pipe: jquery]

(* external prop_get_bool : string -> Js.boolean = "prop" [@@bs.send.pipe: jquery] *)
external prop : string -> string -> jquery = "prop" [@@bs.send.pipe: jquery]
external prop_ : 'a Js.t -> jquery = "prop" [@@bs.send.pipe: jquery]
external prop' : (string,string) attr_func -> jquery = "prop" [@@bs.send.pipe: jquery]

let prop_get (type t) (k : string) : [`str of t | `bool of t | `error] =
	let p = prop_get k in
	let ty, v = Js.Types.reify_type p in
	match (ty : t Js.Types.t) with
	| Js.Types.String -> `str v
	| Js.Types.Boolean -> `bool v
	| _ -> `error;;

let prop at (jq : jquery) : jquery =
	match at with
		| `kv (k,v) -> prop k v jq
		| `map obj -> prop_ obj jq
		| `func f -> prop' f jq;;

external removeAttr : string -> jquery = "removeAttr" [@@bs.send.pipe: jquery]
let removeAttr = removeAttr;;

external removeClass : string -> jquery = "removeClass" [@@bs.send.pipe: jquery]
external removeClass_ : jquery = "removeClass" [@@bs.send.pipe: jquery]
external removeClass' : (string,string) attr_func -> jquery = "removeClass" [@@bs.send.pipe: jquery]

let removeClass at jq =
	match at with
		| `void -> removeClass_ jq
		| `str s -> removeClass s jq
		| `func f -> removeClass' f jq;;

external removeProp : string -> jquery = "removeProp" [@@bs.send.pipe: jquery]

let removeProp = removeProp;;

external toggleClass : string -> jquery = "toggleClass" [@@bs.send.pipe: jquery]
external toggleClass_ : string -> Js.boolean -> jquery = "toggleClass" [@@bs.send.pipe: jquery]
external toggleClass' : (string,string) attr_func -> jquery = "toggleClass" [@@bs.send.pipe: jquery]
external toggleClass'' : (string,string) attr_func -> Js.boolean -> jquery = "toggleClass" [@@bs.send.pipe: jquery]

let to_js_bool b = if b then Js.true_ else Js.false_

let toggleClass at jq =
	match at with
		`str s -> toggleClass s jq
		| `strs ss -> toggleClass (String.concat " " ss) jq
		| `strb (s,b) -> toggleClass_ s (to_js_bool b) jq
		| `strs_b (ss,b) -> toggleClass_ (String.concat " " ss) (to_js_bool b) jq
		| `func f -> toggleClass' f jq
		| `func_b (f,b) -> toggleClass'' f b jq

external val_get : string = "val" [@@bs.send.pipe: jquery]
let val_get = val_get

external val_ : string -> jquery = "val" [@@bs.send.pipe: jquery]
external val_' : (string,string) attr_func -> jquery = "val" [@@bs.send.pipe: jquery]
let val_ at jq =
	match at with
		`str s -> val_ s jq
		| `func f -> val_' f jq

(* CSS: https://api.jquery.com/category/css/ *)
external css_get : string -> string = "css" [@@bs.send.pipe: jquery]
external css_get' : string array -> 'a Js.t = "css" [@@bs.send.pipe: jquery]
let css_get = css_get
let css_get' = css_get'

external css : string -> string -> jquery = "css" [@@bs.send.pipe: jquery]
external css_ : 'a Js.t -> jquery = "css" [@@bs.send.pipe: jquery]
external css' : string -> attr_func_str -> jquery = "css" [@@bs.send.pipe: jquery]
let css at jq =
	match at with
		| `kv (k,v) -> css k v jq
		| `map obj -> css_ obj jq
		| `func (n,f) -> css' n f jq;;

external height_get : int = "height" [@@bs.send.pipe: jquery]
let height_get = height_get

external height : string -> jquery = "height" [@@bs.send.pipe: jquery]
external height_ : int -> jquery = "height" [@@bs.send.pipe: jquery]
external height' : (int, 'a Js.t) attr_func -> jquery = "height" [@@bs.send.pipe: jquery]
let height at jq =
	match at with
		`str v -> height v jq
		| `int v -> height_ v jq
		| `func f -> height' f jq;;

external innerHeight : int = "innerHeight" [@@bs.send.pipe: jquery]
let innerHeight = innerHeight

external innerWidth : int = "innerWidth" [@@bs.send.pipe: jquery]
let innerWidth = innerWidth

external cssHooks : 'a Js.t = "" [@@bs.module "jquery"]
let cssHooks = cssHooks;;

external cssNumber : 'a Js.t = "" [@@bs.module "jquery"]
let cssNumber = cssNumber;;

external escapeSelector : string -> string = "" [@@bs.module "jquery"]
let escapeSelector = escapeSelector;;

external offset_get :  js_coord = "offset" [@@bs.send.pipe: jquery]
let offset_get = offset_get

external offset :  js_coord -> jquery = "offset" [@@bs.send.pipe: jquery]
external offset' : (jquery -> int -> js_coord -> js_coord [@bs.this]) -> jquery = "offset" [@@bs.send.pipe: jquery]

external outerHeight : int = "outerHeight" [@@bs.send.pipe: jquery]
external outerHeight' : Js.boolean -> int = "outerHeight" [@@bs.send.pipe: jquery]
let outerHeight = outerHeight
let outerHeight' = outerHeight'

external outerWidth : int = "outerWidth" [@@bs.send.pipe: jquery]
external outerWidth' : Js.boolean -> int = "outerWidth" [@@bs.send.pipe: jquery]
let outerWidth = outerWidth
let outerWidth' = outerWidth'

external position : js_coord = "position" [@@bs.send.pipe: jquery]
external scrollLeft_get : int = "scrollLeft" [@@bs.send.pipe: jquery]
external scrollLeft : int -> jquery = "scrollLeft" [@@bs.send.pipe: jquery]
external scrollTop_get : int = "scrollTop" [@@bs.send.pipe: jquery]
external scrollTop : int -> jquery = "scrollTop" [@@bs.send.pipe: jquery]
external width_get : int = "width" [@@bs.send.pipe: jquery]
external width : 'a Js.t -> jquery = "width" [@@bs.send.pipe: jquery]
external width' : (int, 'a Js.t) attr_func -> jquery = "width" [@@bs.send.pipe: jquery]

(* Manipulation - Copying *)
external clone : Js.boolean -> Js.boolean -> jquery = "clone" [@@bs.send.pipe: jquery]

(* Manipulation - DOM Insertion, Around *)
external unwrap : jquery = "unwrap" [@@bs.send.pipe: jquery]
external unwrap_ : string -> jquery = "unwrap" [@@bs.send.pipe: jquery]
external wrap : 'a Js.t -> jquery = "wrap" [@@bs.send.pipe: jquery]
external wrap' : (jquery -> int -> 'a Js.t [@bs.this]) -> jquery = "wrap" [@@bs.send.pipe: jquery]
external wrapAll : 'a Js.t -> jquery = "wrapAll" [@@bs.send.pipe: jquery]
external wrapAll' : (jquery -> int -> 'a Js.t [@bs.this]) -> jquery = "wrapAll" [@@bs.send.pipe: jquery]
external wrapInner : 'a Js.t -> jquery = "wrapInner" [@@bs.send.pipe: jquery]
external wrapInner' : (jquery -> int -> 'a Js.t [@bs.this]) -> jquery = "wrapInner" [@@bs.send.pipe: jquery]

(* Manipulation - DOM Insertion, Inside *)
external append : 'a Js.t -> jquery = "append" [@@bs.send.pipe: jquery]
external append' : (string,'a Js.t) attr_func -> jquery = "append" [@@bs.send.pipe: jquery]
external appendTo : jquery -> jquery = "appendTo" [@@bs.send.pipe: jquery]
external appendTo' : (string,'a Js.t) attr_func -> jquery = "appendTo" [@@bs.send.pipe: jquery]
external text_get : string = "text" [@@bs.send.pipe: jquery]
external text : 'a Js.t -> jquery = "text" [@@bs.send.pipe: jquery]
external text' : (string,string) attr_func -> jquery = "text" [@@bs.send.pipe: jquery]

(* Manipulation - DOM Insertion, Outside *)
external after : 'a Js.t -> jquery = "after" [@@bs.send.pipe: jquery]
external after' : (jquery -> int -> 'a Js.t [@bs.this]) -> jquery = "after" [@@bs.send.pipe: jquery]
external after'' : (string,'a Js.t) attr_func -> jquery = "after" [@@bs.send.pipe: jquery]
external before : 'a Js.t -> jquery = "before" [@@bs.send.pipe: jquery]
external before'' : (jquery -> int -> 'a Js.t [@bs.this]) -> jquery = "before" [@@bs.send.pipe: jquery]
external before'' : (string,'a Js.t) attr_func -> jquery = "before" [@@bs.send.pipe: jquery]
external insertAfter : 'a Js.t -> jquery = "" [@@bs.send.pipe: jquery]
external insertBefore : 'a Js.t -> jquery = "" [@@bs.send.pipe: jquery]


(* Manipulation - DOM Removal *)
external detach : string -> jquery = "detach" [@@bs.send.pipe: jquery]
external empty : jquery = "empty" [@@bs.send.pipe: jquery]
external remove : jquery = "remove" [@@bs.send.pipe: jquery]
external remove' : string -> jquery = "remove" [@@bs.send.pipe: jquery]

(* Manipulation - DOM Replacement *)
external replaceAll : 'a Js.t -> jquery = "replaceAll" [@@bs.send.pipe: jquery]
external replaceWith : 'a Js.t -> jquery = "replaceWith" [@@bs.send.pipe: jquery]
external replaceWith' : (jquery -> 'a Js.t [@bs.this]) -> jquery = "replaceWith" [@@bs.send.pipe: jquery]

(* Effects - Basics *)
external toggle : Js.boolean -> jquery = "" [@@bs.send.pipe: jquery]
external hide : jquery = "" [@@bs.send.pipe: jquery]
external show : jquery = "" [@@bs.send.pipe: jquery]

(* Done above*)

(*
(* Effects - Basics *)
external toggle : jquery = "" [@@bs.send.pipe: jquery]

(* Effects - Custom *)
external animate : string -> jquery = "" [@@bs.send.pipe: jquery]
external clearQueue : string -> jquery = "" [@@bs.send.pipe: jquery]
external delay : string -> jquery = "" [@@bs.send.pipe: jquery]
external dequeue : string -> jquery = "" [@@bs.send.pipe: jquery]

(* Effects - Fading *)
external fadeIn : string -> jquery = "" [@@bs.send.pipe: jquery]
external fadeOut : string -> jquery = "" [@@bs.send.pipe: jquery]
external fadeTo : string -> jquery = "" [@@bs.send.pipe: jquery]
external fadeToggle : string -> jquery = "" [@@bs.send.pipe: jquery]

(* Effects - Sliding *)
external slideDown : string -> jquery = "" [@@bs.send.pipe: jquery]
external slideToggle : string -> jquery = "" [@@bs.send.pipe: jquery]
external slideUp : string -> jquery = "" [@@bs.send.pipe: jquery]

*)

(* Events - Browser Events *)
external error : string -> jquery = "" [@@bs.send.pipe: jquery]
external resize : string -> jquery = "" [@@bs.send.pipe: jquery]
external scroll : string -> jquery = "" [@@bs.send.pipe: jquery]

(* Events - Document Loading *)
external load : string -> jquery = "" [@@bs.send.pipe: jquery]
external ready : string -> jquery = "" [@@bs.send.pipe: jquery]
external unload : string -> jquery = "" [@@bs.send.pipe: jquery]

(* Events - Event Handler Attachement *)
external off : string -> jquery = "" [@@bs.send.pipe: jquery]
external on : string -> (jquery -> 'a Js.t -> Js.boolean [@bs.this]) -> jquery = "" [@@bs.send.pipe: jquery]
external on' : string -> string -> (jquery -> 'a Js.t -> Js.boolean [@bs.this]) -> jquery = "on" [@@bs.send.pipe: jquery]
external one : string -> jquery = "" [@@bs.send.pipe: jquery]
external trigger : string -> jquery = "" [@@bs.send.pipe: jquery]
external triggerHandler : string -> jquery = "" [@@bs.send.pipe: jquery]

(* Tree Traversal *)

external closest : string -> jquery = "" [@@bs.send.pipe: jquery]

external find : string -> jquery = "" [@@bs.send.pipe: jquery]

(* Data *)
external data_get : string -> string = "data" [@@bs.send.pipe: jquery]
external data : string -> string -> jquery = "data" [@@bs.send.pipe: jquery]

(* Other *)
external focus : jquery = "" [@@bs.send.pipe: jquery]
external blur : jquery = "" [@@bs.send.pipe: jquery]
external hashchange :  (jquery -> 'a Js.t -> Js.boolean [@bs.this]) -> jquery = "" [@@bs.send.pipe: jquery]


let jquery = jquery;;
(* let addClass = addClass;;
 *)let css = css;;
let outerHeight = outerHeight;;
(* let cssNumber = cssNumber jquery_;; *)


