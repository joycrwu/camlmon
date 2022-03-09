open Level

type t = {
  character_id : string;
  map_id : string;
  health : int;
  inbattle : bool;
  location : int * int;
  alive : bool;
  fought : string list;
}

let init_state lvl = raise (Failure "Unimplemented")
let fought lvl = raise (Failure "Unimplemented")
