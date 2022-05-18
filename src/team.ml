open Graphics
open Raylib
open Yojson.Basic.Util
open Character

type t = {
  team_chars : Character.t list;
  unlocked_chars : Character.t list;
}

let init_team (start_character : Character.t) =
  {
    team_chars = [ start_character ];
    unlocked_chars = [ start_character ];
  }

let get_team_characters team = team.team_chars

let add_helper c team =
  if List.exists (fun x -> c = x) team.unlocked_chars then
    if List.exists (fun x -> c = x) team.team_chars then team.team_chars
    else team.team_chars @ [ c ]
  else failwith "Character not unlocked"

let add c team =
  {
    team_chars = add_helper c team;
    unlocked_chars = team.unlocked_chars;
  }

let rec remove_helper (c : Character.t) team_chars =
  match team_chars with
  | h :: t -> if h != c then [ h ] @ remove_helper c t else t
  | _ -> team_chars

let remove (c : Character.t) team =
  {
    team_chars = remove_helper c team.team_chars;
    unlocked_chars = team.unlocked_chars;
  }

let partner_check (c : Character.t) (char_list : Character.t list) : int
    =
  if
    List.exists
      (fun x -> x = Character.get_partner c)
      (List.map (fun x -> Character.get_id x) char_list)
  then Character.get_partner_effect c
  else 1
