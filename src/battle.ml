type t = {
  character : Character.t;
  character_hp : int;
  enemy : string;
  enemy_hp : int;
}

let init c =
  {
    character = c;
    character_hp = Character.get_hp c;
    enemy = "test";
    enemy_hp = 100;
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

let character bat = bat.character
