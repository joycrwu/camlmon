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
}

type t = {
  id : string;
  hp : int;
  atk : int;
  affinity : string;
  actions : action list;
  partner : partner;
  rarity : int;
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
    parteffect = json |> member "parteffect" |> to_int;
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
    rarity = json |> member "rarity" |> to_int;
  }

let get_id character = character.id
let get_hp character = character.hp
let get_atk character = character.atk
let get_affinity character = character.affinity
let get_action character which = (List.nth character.actions which).name

let get_action_effect character which =
  (List.nth character.actions which).effect

let rec get_aff_effect character enemy aff_list =
  match aff_list with
  | h :: t ->
      if h = get_affinity character && List.hd t = get_affinity enemy
      then 3
      else if
        h = get_affinity enemy && List.hd t = get_affinity character
      then 1 / 3
      else get_aff_effect character enemy t
  | _ -> 1

let get_rarity character = character.rarity
let get_partner character = character.partner.id
let get_partner_effect character = character.partner.parteffect

let check_action character action =
  try List.find (fun r -> r.name = action) character.actions
  with not_found -> raise (UnknownAction action)

let rec aff_effect (character : t) (target : t) (aff_list : string list)
    : int =
  match aff_list with
  | h :: t ->
      if h = character.affinity && List.hd t = target.affinity then 2
      else if h = target.affinity && List.hd t = character.affinity then
        1 / 2
      else aff_effect character target t
  | _ -> 1
