type t
(** The abstract type of values representing a team. *)

val get_team_characters : t -> Character.t list
(** [get_team_characters j] is the list of characters within the team
    [j].*)

val add : Character.t -> t -> t
(**[add c j] adds the character [c] to the team [j], if [c] is within
   the list of characters that the player has unlocked. Does not allow
   duplicate adds.*)

val remove : Character.t -> t -> t
(**[add c j] removes the character [c] from the team [j], if [c] is
   already in the team.*)

val partner_check : Character.t -> Character.t list -> int
(**[partner_check c team] checks whether the partner of character [c] is
   included on team [team], then returns the partner dmg boost effect if
   true*)
