open Character
open Team

type status =
  | Ongoing
  | Won
  | Lost

type t = {
  character : Character.t;
  character_hp : int;
  team : Character.t list;
  enemy : Character.t;
  enemy_hp : int;
  status : status;
}

let init_battle
    (character : Character.t)
    (enemy : Character.t)
    (team : Character.t list) =
  {
    character;
    character_hp = Character.get_hp character;
    team;
    enemy;
    enemy_hp = Character.get_hp enemy;
    status = Ongoing;
  }

let character_hp bat = bat.character_hp
let enemy_hp bat = bat.enemy_hp
let character bat = bat.character
let enemy bat = bat.enemy
let team bat = bat.team

(** return true if we won the battle, false if we lost, meaning that our
    health reached zero first*)
let wonbool bat =
  match bat.status with
  | Won -> true
  | _ -> false

let losebool bat =
  match bat.status with
  | Lost -> true
  | _ -> false

let overbool bat =
  match bat.status with
  | Ongoing -> false
  | _ -> true

let wonbattle bat =
  {
    character = bat.character;
    character_hp = bat.character_hp;
    team = bat.team;
    enemy = bat.enemy;
    enemy_hp = bat.enemy_hp;
    status = Won;
  }

let lostbattle bat =
  {
    character = bat.character;
    character_hp = bat.character_hp;
    team = bat.team;
    enemy = bat.enemy;
    enemy_hp = bat.enemy_hp;
    status = Lost;
  }

(** this code was copied from stackoverflow
    https://stackoverflow.com/questions/31279920/finding-an-item-in-a-list-and-returning-its-index-ocaml*)
let rec find x lst =
  match lst with
  | [] -> raise (Failure "Not Found")
  | h :: t -> if x = h then 0 else 1 + find x t

let character_cycle team (c : Character.t) =
  if List.length team = 1 then List.nth team 0
  else
    match team with
    | h :: t ->
        if List.nth team (List.length team - 1) <> c then
          List.nth team (find c team + 1)
        else List.nth team 0
    | _ -> failwith "not a valid team"

let character_turn_hp c_action_eff bat =
  if c_action_eff < 0 then
    bat.character_hp
    + abs
        (Character.get_atk bat.character
        * c_action_eff
        * Team.partner_check bat.character bat.team)
  else bat.character_hp

let character_turn_enemyhp c_action_eff bat =
  if c_action_eff > 0 then
    bat.enemy_hp
    - Character.get_atk bat.character
      * c_action_eff
      * Team.partner_check bat.character bat.team
      * Character.aff_effect bat.character bat.enemy
          [ "red"; "green"; "blue"; "red" ]
  else bat.enemy_hp

let character_turn c_action_eff bat =
  if character_turn_enemyhp c_action_eff bat <= 0 then wonbattle bat
  else
    {
      character = character_cycle bat.team bat.character;
      character_hp = character_turn_hp c_action_eff bat;
      team = bat.team;
      enemy = bat.enemy;
      enemy_hp = character_turn_enemyhp c_action_eff bat;
      status = bat.status;
    }

let enemy_turn_charhp e_action_eff bat =
  if e_action_eff > 0 then
    bat.character_hp
    - Character.get_atk bat.enemy
      * e_action_eff
      * Character.aff_effect bat.enemy bat.character
          [ "red"; "green"; "blue"; "red" ]
  else bat.character_hp

let enemy_turn_hp e_action_eff bat =
  if e_action_eff < 0 then
    bat.enemy_hp + abs (Character.get_atk bat.enemy * e_action_eff)
  else bat.enemy_hp

let enemy_turn e_action_eff bat =
  if enemy_turn_charhp e_action_eff bat <= 0 then lostbattle bat
  else
    {
      character = bat.character;
      character_hp = enemy_turn_charhp e_action_eff bat;
      team = bat.team;
      enemy = bat.enemy;
      enemy_hp = enemy_turn_hp e_action_eff bat;
      status = bat.status;
    }
