(** Representation of static character data.

    This module represents the data stored in battle_characters files,
    including each character's name, HP levels, attack DMG, character
    affinity, character ability, and allegiance (player character or
    enemy).

    each battle has its own battle_characters, made up of the player's
    chosen characters, and all the enemies available in the battle.

    This module also allows for character actions (attacking, using
    ability). *)

type t
(** The abstract type of values representing battle_characters. *)

exception UnknownCharacter of string
(** Raised when an inaccessible character is called. FINAL: since this
    is selection and not typing do we need this?*)

exception UnknownAction of string
(** Raised when an inaccessible action is called. FINAL: since this is
    selection and not typing do we need this?*)

val start_character : t -> string
(** [start_character a] is the name of the starting character in
    battle_characters [b]. *)

val character_names : t -> string list
(** [character_names a] is a set-like list of all of the character names
    in battle_characters [b]. *)

val atk : t -> int -> int
(** [atk b c] is the atk of character [c] in battle_characters [b].
    Raises [UnknownCharacter c] if [c] is not a character name in [b]. *)

val hp : t -> int -> int
(** [atk b c] is the hp of character [c] in battle_characters [b].
    Raises [UnknownCharacter c] if [c] is not a character name in [b]. *)

val ability : t -> string -> string
(** [atk b c] is the ability of character [c] in battle_characters [b].
    When used, should have an effect on ally HP, ally ATK, enemy HP,
    enemy ATK. Raises [UnknownCharacter c] if [c] is not a character
    name in [b]. *)

val affinity : t -> string -> string
(** [atk b c] is the affinity of character [c] in battle_characters [b].
    Raises [UnknownCharacter c] if [c] is not a character name in [b]. *)

val allegiance : t -> string -> string
(** [atk b c] is the allegiance of character [c] in battle_characters
    [b]. Raises [UnknownCharacter c] if [c] is not a character name in
    [b]. *)

val targets : t -> string -> string list
(** [targets b c] is a set-like list of all target names character [c]
    can attack within battle_characters [b]. Raises [UnknownCharacter c]
    if [c] is not a character name in [b]. *)

val atk_target : t -> string -> string -> string
(** [atk_target b c t] is the target character [t] from
    battle_characters [b] which is being attacked by character [c].
    Raises [UnknownCharacter c] if [c] or [t] are not character names in
    [b]. *)
