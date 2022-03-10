open Level
open Character

type t
(** The abstract type of values representing the game state. *)

val init_state : Level.t -> t
(** [init_state a] is the initial state of the game when playing on a
    level [a]. In that state the character is currently located in the
    starting tile, and they have visited only that tile. *)

val current_tile_id : t -> int * int
(** [current_tile_id st] is the identifier of the tile in which the
    adventurer currently is located in state [st]. Location is
    represented in coordinate form, where int * int is (x * y) *)

val fought : t -> string list
(** [fought st] is the list of all the character ids that the user has
    fought *)

val current_character : t -> Character.t
(** [current_character st] is the current in-battle character.*)