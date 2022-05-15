(** Representation of hatchery data*)

type t
(**The abstract type representating a hatchery instance.*)

val new_hatchery : unit -> t
(**Creates a new hatchery with no characters in it yet.*)

val add_char_to_pool : t -> Character.t -> t
val get_normal_char_pool : t -> Character.t list
val get_rare_char_pool : t -> Character.t list
val get_ssr_char_pool : t -> Character.t list
val gacha : t -> Character.t
val character_outputs : Character.t -> t -> t
