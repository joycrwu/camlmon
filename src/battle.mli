type t
(** The abstract type of values representing a character. *)

val init_battle : Character.t -> Character.t -> t
(**[init_battle c e ] is the type [t] for a battle, with character [c]
   and enemy [e]. *)

val character_hp : t -> int
val enemy_hp : t -> int
val character : t -> Character.t
val enemy : t -> Character.t

val character_turn : int -> t -> t
(** [character_turn b] is the character turn in battle [b]*)

val enemy_turn : int -> t -> t
(** [enemy_turn b] is the enemy turn in battle [b]*)

val damage : 'a -> 'b
val wonbattle : t -> bool