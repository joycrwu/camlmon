open Character

type t = {
  character : string;
  character_hp : int;
  c_action_eff : int;
  enemy : string;
  enemy_hp : int;
  e_action_eff : int;
}

let character_turn bat =
  {
    character = bat.character;
    character_hp =
      (if bat.c_action_eff > 0 then bat.character_hp + bat.c_action_eff
      else bat.character_hp);
    c_action_eff = bat.c_action_eff;
    enemy = bat.enemy;
    enemy_hp =
      (if bat.c_action_eff < 0 then bat.enemy_hp + bat.c_action_eff
      else bat.enemy_hp);
    e_action_eff = bat.e_action_eff;
  }

let enemy_turn bat =
  {
    character = bat.character;
    character_hp =
      (if bat.e_action_eff < 0 then bat.character_hp + bat.e_action_eff
      else bat.character_hp);
    c_action_eff = bat.c_action_eff;
    enemy = bat.enemy;
    enemy_hp =
      (if bat.e_action_eff > 0 then bat.enemy_hp + bat.e_action_eff
      else bat.enemy_hp);
    e_action_eff = bat.e_action_eff;
  }

let damage bat = raise (Failure "Unimplemented")
let character bat = bat.character

(** return true if we won the battle, false if we lost, meaning that our
    health reached zero first*)
let wonbattle bat = raise (Failure "Unimplemented")
