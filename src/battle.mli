type status =
| Ongoing
| Won
| Lost
(** The type status represents the current status of the battle, which can be
    either ongoing, won or lost. *)

type t
(** The abstract type of values representing a character. *)

val init_battle : Character.t -> Character.t -> Character.t list -> t
(**[init_battle c e t ] is the type [t] for a battle, with character
   [c], enemy [e], and team [t]. *)

val character_hp : t -> int
(** [character_hp t] is the hp of the player character in battle [t]. *)
val enemy_hp : t -> int
(** [enemy_hp t] is the hp of the enemy in battle [t]. *)
val character : t -> Character.t
(** [character t] is the character id of the player character in battle [t]. *)
val enemy : t -> Character.t
(** [enemy t] is the id of the enemy in battle [t]. *)
val team : t -> Character.t list
(** [team t] is the list of available characters in battle [t]. *)

val character_turn : int -> t -> t
(** [character_turn a t] is the character turn in battle [b], which takes in 
    an integer action [a] and applies it to the battle state. *)

val enemy_turn : int -> t -> t
(** [enemy_turn a t] is the enemy turn in battle [b], which takes in 
    an integer action [a] and applies it to the battle state. *)

val wonbool : t -> bool
(** [wonbattle t] returns true if the battle [b] was won, which occurs when the 
    enemy hp has reached or is less than zero. *)
val losebool : t -> bool
(** [losebattle t] returns true if the battle [b] was lost, which occurs when 
    the playable character hp has reached or is less than zero. *)
val overbool : t -> bool
(** [overbattle t] returns true if the battle [b] is over, which occurs when 
    the status of the battle is Won or Lost. *)

val wonbattle : t -> t
(** [wonbattle t] returns a new battle state where the status of the battle is
    Won of type status.*)
val lostbattle : t -> t
(** [lostbattle t] returns a new battle state where the status of the battle is
    Lost of type status.*)