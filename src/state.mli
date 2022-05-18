open Level

type status =
  | Start
  | Level
  | Team
  | Battle
  | Hatchery
  | Endscreen of bool

(** The various types of status that represent the phases of the game. *)

type t
(** The abstract type of values representing the game state. *)

val current_health : t -> int
(** [current_health st] is the current health level in a given state.*)

val current_tile_id : t -> int * int
(** [current_tile_id st] is the current location in a given state.*)

val current_level : t -> Level.t
(** [current_level st] is the current level in a given state. *)

val get_x : t -> float
(** [get_x st] is the pixel x value in the current state [st]. *)

val get_y : t -> float
(** [get_y st] is the pixel y value in the current state [st]. *)

val current_team : t -> Character.t list
(** [current_team st] is the current team in a given state. *)

val current_character_pool : t -> Character.t list
(** [current_character_pool st] is the current playable character pool
    of a given state. *)

val get_num_levels : t -> int
(** [get_num_levels st] is the number of levels that the character has
    traversed through in a given state.*)

val init_state : Level.t -> Character.t -> t
(** [init_state a] is the initial state of the game when playing on a
    level [a]. In that state the character is currently located in the
    starting tile, and they have visited only that tile. *)

val move : t -> int -> int -> t
(** [move st x y] changes the current location of the state to the newly
    inputted x and y units. *)

val new_level : t -> Level.t -> t
(** [new_level st lvl] changes the level of the state.*)

val new_playable_char : t -> Character.t -> t
(** [new_playable_character st ch] adds [ch] into the pool of possible
    playable characters.*)

val add_to_team : t -> Character.t -> t
(** [add_to_team st ch] adds [ch] as a character on the current team if
    there is still room on the team for another character. The maximum
    number of characters on a team is 3.*)

val remove_from_team : t -> Character.t -> t
(** [remove_from_team st ch] removes [ch] from the current team if [ch]
    exists on the current team. *)

val change_hp : t -> int -> t
(** [change_hp st change] changes the current state's HP by [change].*)

val status : t -> status
(** [get_state st] is the current status of [st], such as the start
    screen, world map, battle or hatchery. *)

val to_battle : t -> t
(** [to_battle st] is st with the status changed to battle. *)

val to_level : t -> t
(** [to_level st] is st with the status changed to level. *)

val to_team : t -> t
(** [to_team st] is st with the status changed to team. *)

val to_hatchery : t -> t
(** [to_hatchery st] is st with the status changed to hatchery. *)

val to_endscreen : t -> bool -> t
(** [to_endscreen_win st win] is st with the status changed to Endscreen
    true if we won the Dijkstra battle and Endscreen false if we lost.*)
