open Yojson.Basic.Util

exception UnknownAction of string
exception IllegalTarget of string

type action = {
  name : string;
  effect : int;
}

type t = {
  id : string;
  hp : int;
  atk : int;
  affinity : string;
  actions : action list;
}

let get_action_json json =
  {
    name = json |> member "name" |> to_string;
    effect = json |> member "name" |> to_int;
  }

let from_json json =
  {
    id = json |> member "id" |> to_string;
    hp = json |> member "hp" |> to_int;
    atk = json |> member "atk" |> to_int;
    affinity = json |> member "affinity" |> to_string;
    actions =
      json |> member "actions" |> to_list |> List.map get_action_json;
  }

let get_id character = character.id
let get_hp character = character.hp
let get_atk character = character.atk
let get_affinity character = character.affinity

let get_action_effect character which =
  (List.nth character.actions which).effect

let check_action character action =
  try List.find (fun r -> r.name = action) character.actions
  with not_found -> raise (UnknownAction action)
