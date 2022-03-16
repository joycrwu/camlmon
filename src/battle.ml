open Character

type t = {
  character : Character.t;
  character_hp : int;
  enemy : Character.t;
  enemy_hp : int;
}

let init_battle (character : Character.t) (enemy : Character.t) =
  {
    character;
    character_hp = Character.get_hp character;
    enemy;
    enemy_hp = Character.get_hp enemy;
  }

let character_turn bat c_action_eff =
  {
    character = bat.character;
    character_hp =
      (if c_action_eff > 0 then bat.character_hp + c_action_eff
      else bat.character_hp);
    enemy = bat.enemy;
    enemy_hp =
      (if c_action_eff < 0 then bat.enemy_hp + c_action_eff
      else bat.enemy_hp);
  }

let enemy_turn bat e_action_eff =
  {
    character = bat.character;
    character_hp =
      (if e_action_eff < 0 then bat.character_hp + e_action_eff
      else bat.character_hp);
    enemy = bat.enemy;
    enemy_hp =
      (if e_action_eff > 0 then bat.enemy_hp + e_action_eff
      else bat.enemy_hp);
  }

let damage bat = raise (Failure "Unimplemented")
let character bat = bat.character

(** return true if we won the battle, false if we lost, meaning that our
    health reached zero first*)
let wonbattle bat = raise (Failure "Unimplemented")
