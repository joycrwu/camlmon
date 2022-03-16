open String
open Yojson.Basic.Util

type t = {
  level_id : string;
  start_tile : int * int;
  characterid : string;
  enemylist : string list;
}

let currentlvl_character (lvl : t) = raise (Failure "Unimplemented")
let get_characterid (lvl : t) = raise (Failure "Unimplemented")
let start_location (lvl : t) = raise (Failure "Unimplemented")
let get_map (lvl : t) = raise (Failure "Unimplemented")
let get_health (lvl : t) = raise (Failure "Unimplemented")
