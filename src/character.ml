open Yojson.Basic.Util

exception UnknownCharacter of string
exception UnknownAction of string
exception IllegalTarget of string

type action = {
  name : string;
  effect : int;
  target : string;
}

type character = {
  id : string;
  hp : int;
  atk : int;
  affinity : string;
  allegiance : string;
  actions : action list;
}

type t = {
  start_character : string;
  characters : character list;
}

let get_action json =
  {
    name = json |> member "name" |> to_string;
    effect = json |> member "name" |> to_int;
    target = json |> member "character_id" |> to_string;
  }

let get_character json =
  {
    id = json |> member "id" |> to_string;
    hp = json |> member "hp" |> to_int;
    atk = json |> member "atk" |> to_int;
    affinity = json |> member "affinity" |> to_string;
    allegiance = json |> member "allegiance" |> to_string;
    actions = json |> member "actions" |> to_list |> List.map get_action;
  }

let from_json json =
  {
    start_character = json |> member "start character" |> to_string;
    characters =
      json |> member "characters" |> to_list |> List.map get_character;
  }

let check_character battle character =
  try List.find (fun r -> r.id = character) battle.characters
  with not_found -> raise (UnknownCharacter character)

let check_action character action =
  try List.find (fun r -> r.name = action) character.actions
  with not_found -> raise (UnknownAction action)

let rec make_setlist (lst : string list) =
  match lst with
  | [] -> []
  | h :: t -> [ h ] @ make_setlist (List.filter (fun x -> x <> h) t)

let start_character battle = battle.start_character

let rec character_id_helper
    (characters : character list)
    (ans : string list) =
  match characters with
  | h :: t -> character_id_helper t (ans @ [ h.id ])
  | _ -> ans

let character_ids (battle : t) =
  make_setlist (character_id_helper battle.characters [])

let rec actions_helper (actions : action list) (ans : string list) =
  match actions with
  | h :: t -> actions_helper t (ans @ [ h.name ])
  | _ -> ans

let actions battle character =
  make_setlist
    (actions_helper (check_character battle character).actions [])

let target battle character action =
  let target_c =
    List.find
      (fun r ->
        r.id
        = (check_action (check_character battle character) action)
            .target)
      battle.characters
  in
  if
    target_c.allegiance != (check_character battle character).allegiance
  then target_c.id
  else raise (IllegalTarget target_c.id)

let rec targets_helper (actions : action list) (ans : string list) =
  match actions with
  | h :: t -> targets_helper t (ans @ [ h.target ])
  | _ -> ans

let targets battle character =
  make_setlist
    (targets_helper (check_character battle character).actions [])
