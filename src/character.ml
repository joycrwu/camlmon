open Yojson.Basic.Util

exception UnknownAction of string
exception IllegalTarget of string

type action = {
  name : string;
  effect : int;
  description : string;
}

type partner = {
  id : string;
  parteffect : int;
  onteam : bool;
}

type t = {
  id : string;
  hp : int;
  atk : int;
  affinity : string;
  actions : action list;
  partner : partner;
}

let get_action_json json =
  {
    name = json |> member "name" |> to_string;
    effect = json |> member "effect" |> to_int;
    description = json |> member "description" |> to_string;
  }

let get_partner_json json =
  {
    id = json |> member "id" |> to_string;
    parteffect = json |> member "effect" |> to_int;
    onteam = json |> member "onteam" |> to_bool;
  }

let from_json json =
  {
    id = json |> member "id" |> to_string;
    hp = json |> member "hp" |> to_int;
    atk = json |> member "attack" |> to_int;
    affinity = json |> member "affinity" |> to_string;
    actions =
      json |> member "actions" |> to_list |> List.map get_action_json;
    partner = json |> member "partner" |> get_partner_json;
  }

let get_id character = character.id
let get_hp character = character.hp
let get_atk character = character.atk
let get_affinity character = character.affinity
let get_action character which = (List.nth character.actions which).name

let get_action_effect character which =
  (List.nth character.actions which).effect

let get_partner character = character.partner
let get_partner_effect character = character.partner.parteffect
let get_onteam character = character.partner.onteam

let check_action character action =
  try List.find (fun r -> r.name = action) character.actions
  with not_found -> raise (UnknownAction action)
