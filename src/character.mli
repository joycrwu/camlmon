(** Representation of character data.

    This module represents the data stored in character files. It
    handles loading of that data from JSON as well as querying the data. *)

type t
(** The abstract type of values representing a character. *)

val from_json : Yojson.Basic.t -> t
(** [from_json j] is the character that [j] represents. Requires: [j] is
    a valid JSON character representation. *)

exception UnknownAction of string
(** Raised when an inaccessible action is called. FINAL: since this is
    selection and not typing do we need this?*)

val from_json : Yojson.Basic.t -> t
(** [from_json j] is the battle that [j] represents. Requires: [j] is a
    valid JSON battle representation. *)

val get_id : t -> string
(**[get_id c] is the id of character [c]*)

val get_hp : t -> int
(**[get_hp c] is the hp of character [c]*)