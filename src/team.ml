open Character

type t = {
  teamslot : int;
  characters : string list;
}

let get_team_num team = team.teamslot
let get_team_characters team = team.characters
let add c team = team.characters @ [ Character.get_id c ]

let rec remove c team =
  match team with
  | h :: t -> if h != Character.get_id c then [ h ] @ remove c t else t
  | _ -> team

let partner_check (c : Character.t) (team : string list) =
  if List.exists (fun x -> x = Character.get_partner c) team then
    Character.get_partner_effect c
  else 0
