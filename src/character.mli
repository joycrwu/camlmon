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
(** Representation of static character data.

    This module represents the data stored in battle files, including
    each character's name, HP levels, attack DMG, character affinity,
    character ability, and allegiance (player character or enemy).

    each battle has its own battle_characters, made up of the player's
    chosen characters, and all the enemies available in the battle.

    This module also allows for character actions (attacking, using
    ability). *)

type t
(** The abstract type of values representing battle. *)

exception UnknownCharacter of string
(** Raised when an inaccessible character is called. FINAL: since this
    is selection and not typing do we need this?*)

exception UnknownAction of string
(** Raised when an inaccessible action is called. FINAL: since this is
    selection and not typing do we need this?*)

exception IllegalTarget of string
(**Raised when a character tries an action on an illegal target. Ex:
   healing an enemy, attacking an ally*)

val from_json : Yojson.Basic.t -> t
(** [from_json j] is the battle that [j] represents. Requires: [j] is a
    valid JSON battle representation. *)

val start_character : t -> string
(** [start_character a] is the name of the starting character in battle
    [b]. *)

val character_names : t -> string list
(** [character_names a] is a set-like list of all of the character names
    in battle [b]. *)

val atk : t -> int -> int
(** [atk b c] is the atk of character [c] in battle [b]. Raises
    [UnknownCharacter c] if [c] is not a character name in [b]. *)

val hp : t -> int -> int
(** [atk b c] is the hp of character [c] in battle [b]. Raises
    [UnknownCharacter c] if [c] is not a character name in [b]. *)

val ability : t -> string -> string
(** [atk b c] is the ability of character [c] in battle [b]. When used,
    should have an effect on ally HP, ally ATK, enemy HP, enemy ATK.
    Raises [UnknownCharacter c] if [c] is not a character name in [b]. *)

val affinity : t -> string -> string
(** [atk b c] is the affinity of character [c] in battle [b]. Raises
    [UnknownCharacter c] if [c] is not a character name in [b]. *)

val allegiance : t -> string -> string
(** [atk b c] is the allegiance of character [c] in battle [b]. Raises
    [UnknownCharacter c] if [c] is not a character name in [b]. *)

val targets : t -> string -> string list
(** [targets b c] is a set-like list of all target names character [c]
    can attack within battle [b]. Raises [UnknownCharacter c] if [c] is
    not a character name in [b]. *)

val attack : t -> string -> string -> string
(** [attack a b c t] is the attack [a] being used against target
    character [t] from battle

    [b] by character [c]. Raises [UnknownCharacter c] if [c] or [t] are
    not character names in [b], or [UnknownAction a] if [a] is not a
    valid attack. *)
