open Character
open Team

type t = {
  character : Character.t;
  character_hp : int;
  team : Character.t list;
  enemy : Character.t;
  enemy_hp : int;
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
  }

let character_hp bat = bat.character_hp
let enemy_hp bat = bat.enemy_hp
let character bat = bat.character
let enemy bat = bat.enemy
let team bat = bat.team

(** this code was copied from stackoverflow
    https://stackoverflow.com/questions/31279920/finding-an-item-in-a-list-and-returning-its-index-ocaml*)
let rec find x lst =
  match lst with
  | [] -> raise (Failure "Not Found")
  | h :: t -> if x = h then 0 else 1 + find x t

let character_cycle team c =
  if find c team = List.length team - 1 then List.nth team 0
  else List.nth team (find c team + 1)

let character_turn_hp c_action_eff bat =
  if c_action_eff < 0 then
    bat.character_hp
    - Character.get_atk bat.character
      * c_action_eff
      * Team.partner_check bat.character bat.team
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
  {
    character = character_cycle bat.team bat.character;
    character_hp = character_turn_hp c_action_eff bat;
    team = bat.team;
    enemy = bat.enemy;
    enemy_hp = character_turn_enemyhp c_action_eff bat;
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
    bat.enemy_hp - (Character.get_atk bat.enemy * e_action_eff)
  else bat.enemy_hp

let enemy_turn e_action_eff bat =
  {
    character = bat.character;
    character_hp = enemy_turn_charhp e_action_eff bat;
    team = bat.team;
    enemy = bat.enemy;
    enemy_hp = enemy_turn_charhp e_action_eff bat;
  }

(** return true if we won the battle, false if we lost, meaning that our
    health reached zero first*)
let wonbattle bat = bat.enemy_hp <= 0

let losebattle bat = bat.character_hp <= 0
