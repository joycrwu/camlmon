open Level

type t
(** The abstract type of values representing the game state. *)

val current_health : t -> int
(** [current_health st] is the current health level in a given state.*)

val current_tile_id : t -> int
(** [current_tile_id st] is the current location in a given state.*)

val current_level : t -> int
(** [current_level st] is the current level in a given state. *)

val current_team : t -> Character.t list
(** [current_team st] is the current team in a given state. *)

val current_character_pool : t -> Character.t list
(** [current_character_pool st] is the current playable character pool
    of a given state. *)

val init_state : Level.t -> Character.t -> t
(** [init_state a] is the initial state of the game when playing on a
    level [a]. In that state the character is currently located in the
    starting tile, and they have visited only that tile. *)

val move : t -> int -> int -> t
(** [move st x y] changes the current location of the state to the newly
    inputted x and y units. *)

val new_playable_character : t -> Character.t -> t
(** [new_playable_character st ch] adds [ch] as a new playable character
    to the character pool. *)

val add_to_team : t -> Character.t -> t
(** [add_to_team st ch] adds [ch] as a character on the current team if
    there is still room on the team for another character. The maximum
    number of characters on a team is 3.*)

val remove_from_team : t -> Character.t -> t
(** [remove_from_team st ch] removes [ch] from the current team if [ch]
    exists on the current team. *)

val change_hp : t -> int -> t
(** [change_hp st change] changes the current state's HP by [change].*)
