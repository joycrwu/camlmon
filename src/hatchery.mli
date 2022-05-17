(*Representation of hatchery data*)

type t
(**The abstract type representating a hatchery instance.*)

val new_hatchery : unit -> t
(** [new_hatchery] creates a new hatchery with no characters in any of
    the pools yet.*)

val add_char_to_pool : t -> Character.t -> t
(** [add_char_to_pool hat ch] takes in a hatchery instance [hat] and a
    character [ch] and adds the [ch] to the appropriate rarity pool in
    [hat] depending on the rarity of the character.*)

val get_normal_char_pool : t -> Character.t list
(** [get_normal_char_pool hat] takes in a hatchery instance [hat] and
    returns the pool of normal characters available.*)

val get_rare_char_pool : t -> Character.t list
(** [get_rare_char_pool hat] takes in a hatchery instance [hat] and
    returns the pool of rare characters available.*)

val get_ssr_char_pool : t -> Character.t list
(** [get_ssr_char_pool hat] takes in a hatchery instance [hat] and
    returns the pool of SSR characters available.*)

val gacha : t -> Character.t
(** [gacha hat] takes in a hatchery instance [hat] and randomly outputs
    a character from one of the pools: normal, rare, or SSR.*)

val character_outputs : Character.t -> t -> t
(** [character_outputs ch hat] takes in a character [ch] and a hatchery
    instance [hat] and adds the new character into the output characters
    of the current hatchery.*)
