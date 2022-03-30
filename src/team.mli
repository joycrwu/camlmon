type t
(** The abstract type of values representing a team. *)

val get_team_num : t -> int
(** [get_team_num j] is the identification number of the team [j].*)

val get_team_characters : t -> string list
(** [get_team_characters j] is the list of the characters in the team
    [j].*)

val add : Character.t -> t -> string list
(**[add c team] allows the player to add the character [c] into team
   [team]*)

val remove : Character.t -> string list -> string list
(**[remove c team] allows the palyer to remove the character [c] from
   team [team]*)

val partner_check : Character.t -> string list -> int
(**[partner_check c team] checks whether the partner of character [c] is
   included on team [team], then returns the partner dmg boost effect if
   true*)
