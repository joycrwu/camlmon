open Level

type t
(** The abstract type of values representing the game state. *)

val init_state : Level.t -> t
(** [init_state a] is the initial state of the game when playing
    adventure [a]. In that state the adventurer is currently located in
    the starting room, and they have visited only that room. *)

(* val current_location : t -> int * int (** [current_room_id st] is the
   identifier of the room in which the adventurer currently is located
   in state [st]. *) *)
