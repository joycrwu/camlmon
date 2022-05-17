(** The tile type represents the different tile types that make up a level *)
type tile =
  | Grass
  | Water
  | Road
  | Exit

type t
(** The abstract type of values representing the map of a level. *)

val get_characterid : t -> string
(** [current_character t] returns the id of is the current character
    controlled by the user in current state.*)

(** val currentlvl_character : t -> Character.t *)
(** [current_character lvl] returns the character curentally being
    controlled by the user in the [lvl].*)

val start_location : t -> int * int
(** [start_location lvl] the starting location of the current level, in terms 
    of pixels rather than tiles. *)

val get_map : t -> string
(** [get_map t] is the list of all the character ids that the user has
    fought *)

val get_tile : int -> int -> t -> tile
(** [get_tile x y t] is the tile type at (x, y), which represent the coordinate
    plane in pixels. *)
val init_lvl : int -> int -> t
(** [init_lvl w h] creates a level [t] with pixel width [w] and height [h]. *)
val draw_lvl : t -> unit
(** [draw_lvl t] consists of raylib drawing functions that draw the level [t].*)
val from_json : Yojson.Basic.t -> t
(** [from_json j] is the level that [j] represents. Requires: [j] is
        a valid JSON character representation. *)
val random_level : t 
(** [random_level] is a random level type from data/level.*)
val next_level : t -> t
(** [next_level lvl] takes in an input level and outputs the level that is 
    sequentially after the input level in the game data files. *)