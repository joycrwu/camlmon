open String
open Yojson.Basic.Util
open Character

type direction =
  | Left
  | Right
  | Up
  | Down

type action =
  | Move of direction
  | Fight
  | Heal

type t = {
  level_id : string;
  start_tile : int * int;
  characterid : string;
  enemylist : string list;
  affinity_order : string list;
}

let currentlvl_character (lvl : t) = lvl.characterid
let get_characterid (lvl : t) = lvl.characterid
let start_location (lvl : t) = lvl.start_tile
let get_map (lvl : t) = lvl.level_id
let get_affinity_order (lvl : t) = lvl.affinity_order