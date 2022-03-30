open Character

type t
(** The abstract type of values representing the map of a level. *)

val get_characterid : t -> string
(** [current_character st] returns the id of is the current character
    controlled by the user in current state.*)

(* val currentlvl_character : t -> Character.t *)
(** [current_character lvl] returns the character curentally being
    controlled by the user in the [lvl].*)

val start_location : t -> int * int
(** [start_location lvl] the starting location of the current level *)

val get_map : t -> string
(** [get_map st] is the list of all the character ids that the user has
    fought *)
