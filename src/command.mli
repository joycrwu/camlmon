(** Interprets player commands *)

(** The type [command] represents a player's command. *)
type command =
  | Attack of int
  | Run
  | Exit
  | Invalid_input

val input : Battle.t -> Character.t -> command
(** [input s] pattern matches the pressed key to a [command]. *)
