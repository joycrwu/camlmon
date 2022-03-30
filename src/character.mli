(** Representation of character data.

    This module represents the data stored in character files. It
    handles loading of that data from JSON as well as querying the data. *)

exception UnknownAction of string
(** Raised when an inaccessible action is called. FINAL: since this is
        selection and not typing do we need this?*)
type t
(** The abstract type of values representing a character. *)

val from_json : Yojson.Basic.t -> t
(** [from_json j] is the character that [j] represents. Requires: [j] is
    a valid JSON character representation. *)

val get_id : t -> string
(** [get_id c] is the id of the character [c].*)

val get_hp : t -> int
(** [get_hp c] is the hp of the character [c].*)

val get_atk : t -> int
(** [get_atk c] is the atk of the character [c].*)

val get_affinity : t -> string
(** [get_affinity c] is the affinity of the character [c].*)

val get_action : t -> int -> string
(** [get_action c n] is the action name of the [n]th ability of the character [c].*)

val get_partner : t -> string

val get_partner_effect : t -> int

val get_action_effect : t -> int -> int
(** [get_action_effect c n] is the effect int of the [n]th ability of the character [c].*)
