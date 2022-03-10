(** Representation of character data.

    This module represents the data stored in character files. It
    handles loading of that data from JSON as well as querying the data. *)

type t
(** The abstract type of values representing a character. *)

val from_json : Yojson.Basic.t -> t
(** [from_json j] is the character that [j] represents. Requires: [j] is
    a valid JSON character representation. *)

val attack : t -> int -> string
(** [attack k] is the name of the kth attack of character [c]. *)
