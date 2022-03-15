type t = {
  character : string;
  character_hp : int;
  enemy : string;
  enemy_hp : int;
}

let character_turn bat atk =
  {
    character = bat.character;
    character_hp = bat.character_hp;
    enemy = bat.enemy;
    enemy_hp = bat.enemy_hp - 10;
  }

let enemy_turn bat =
  {
    character = bat.character;
    character_hp = bat.character_hp - 10;
    enemy = bat.enemy;
    enemy_hp = bat.enemy_hp;
  }

let damage bat = raise (Failure "Unimplemented")
let character bat = bat.character

(** return true if we won the battle, false if we lost, meaning that our
    health reached zero first*)
let wonbattle bat = raise (Failure "Unimplemented")
