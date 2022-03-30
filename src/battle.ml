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

let rec character_cycle team c =
  match team with
  | h :: t -> if h = c then List.hd t else character_cycle t c
  | _ -> c

let character_turn c_action_eff bat =
  {
    character = character_cycle bat.team bat.character;
    character_hp =
      (if c_action_eff < 0 then
       bat.character_hp
       - Character.get_atk bat.character
         * ((Team.partner_check bat.character
               (List.map (fun x -> Character.get_id x) bat.team)
            + c_action_eff)
           / 2)
      else bat.character_hp);
    team = bat.team;
    enemy = bat.enemy;
    enemy_hp =
      (if c_action_eff > 0 then
       bat.enemy_hp
       - Character.get_atk bat.character
         * (Team.partner_check bat.character
              (List.map (fun x -> Character.get_id x) bat.team)
           + c_action_eff)
      else bat.enemy_hp);
  }

let enemy_turn e_action_eff bat =
  {
    character = bat.character;
    character_hp =
      (if e_action_eff > 0 then
       bat.character_hp - (Character.get_atk bat.enemy * e_action_eff)
      else bat.character_hp);
    team = bat.team;
    enemy = bat.enemy;
    enemy_hp =
      (if e_action_eff < 0 then
       bat.enemy_hp - (Character.get_atk bat.enemy * e_action_eff)
      else bat.enemy_hp);
  }

let damage bat = raise (Failure "Unimplemented")

(** return true if we won the battle, false if we lost, meaning that our
    health reached zero first*)
let wonbattle bat = bat.enemy_hp <= 0

let losebattle bat = bat.character_hp <= 0
