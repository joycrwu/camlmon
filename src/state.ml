open Level
open Character
open Battle

type status =
  | Start
  | Level
  | Battle
  | Hatchery

type t = {
  team : Character.t list;
  health : int;
  level : string;
  location : int * int;
  character_pool : Character.t list;
  state : status;
}

(**STATE GETTER FUNCTIONS**)
let current_health st = st.health

let current_tile_id st = st.location
let current_level st = st.level
let current_team st = st.team
let current_character_pool st = st.character_pool

(**END OF STATE GETTER FUNCTIONS**)

let init_state (lvl : Level.t) (starter : Character.t) =
  let t =
    {
      team = [ starter ];
      level = get_map lvl;
      health = get_hp starter;
      location = start_location lvl;
      character_pool = [ starter ];
      state = Start;
    }
  in
  t

(* let fought (st : t) ene = let t = { character = st.character; map_id
   = st.map_id; health = st.health; levelmap = "level"; location =
   st.location; alive = true; fought = ene :: st.fought; usable = [];
   inventory = []; } in t *)

let move st (x : int) (y : int) =
  {
    team = st.team;
    health = st.health;
    level = st.level;
    location = (x, y);
    character_pool = st.character_pool;
    state = st.state;
  }

(*not done, probably needs a way to decide which battle it is
  entering *)
(* let battle st x y = { character = st.character; map_id = st.map_id;
   health = st.health; levelmap = "fight"; location = (x, y); alive =
   st.alive; fought = st.fought; usable = []; inventory = []; } *)

(* hatchery is a new location, where u can get new characters by
   gatchaing for them. Not yet implemented *)
let new_playable_char st (ch : Character.t) =
  {
    team = st.team;
    level = st.level;
    health = st.health;
    location = st.location;
    character_pool = ch :: st.character_pool;
    state = st.state;
  }

(*team is the set of characters that the player chooses to use in a
  battle. Not yeet implemented.*)

let add_to_team st (ch : Character.t) =
  if List.length st.team < 3 then
    {
      team = ch :: st.team;
      level = st.level;
      health = st.health;
      location = st.location;
      character_pool = st.character_pool;
      state = st.state;
    }
  else st

let remove_from_team st (ch : Character.t) =
  if List.length st.team > 0 then
    {
      team = List.filter (fun x -> x <> ch) st.team;
      level = st.level;
      health = st.health;
      location = st.location;
      character_pool = st.character_pool;
      state = st.state;
    }
  else st

let change_hp st (change : int) =
  {
    team = st.team;
    level = st.level;
    health = st.health + change;
    location = st.location;
    character_pool = st.character_pool;
    state = st.state;
  }

(* obtainchar is for when u obtain a new character from the hatchery.
   Not yet implemented!!! *)
(* let obtainchar st chara = { character = st.character; map_id =
   st.map_id; health = st.health; levelmap = st.levelmap; location =
   st.location; alive = st.alive; fought = st.fought; usable = chara ::
   st.usable; inventory = st.inventory; } *)

(* getitem is for when u obtain a new character from the hatchery. Not
   yet implemented!!! *)
(* let getitem st item = { character = st.character; map_id = st.map_id;
   health = st.health; levelmap = st.levelmap; location = st.location;
   alive = st.alive; fought = st.fought; usable = st.usable; inventory =
   item :: st.inventory; } *)

let get_state st = st.state

let to_level st st =
  {
    team = st.team;
    level = st.level;
    health = st.health;
    location = st.location;
    character_pool = st.character_pool;
    state = Level;
  }

let to_battle st =
  {
    team = st.team;
    level = st.level;
    health = st.health;
    location = st.location;
    character_pool = st.character_pool;
    state = Battle;
  }

let to_level st =
  {
    team = st.team;
    level = st.level;
    health = st.health;
    location = st.location;
    character_pool = st.character_pool;
    state = Hatchery;
  }
