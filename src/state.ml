open Level
open Character
open Battle

type direction =
  | Left
  | Right
  | Up
  | Down

type action =
  | Move of direction
  | Fight
  | Heal

type t = {
  character : Character.t;
  map_id : string;
  health : int;
  levelmap : string;
  location : int * int;
  alive : bool;
  fought : string list;
  usable : string list;
  inventory : string list;
}

let init_state (lvl : Level.t) character =
  let t =
    {
      character;
      map_id = get_map lvl;
      health = 0;
      levelmap = "level";
      location = start_location lvl;
      alive = true;
      fought = [];
      usable = [];
      inventory = [];
    }
  in
  t

let fought (st : t) ene =
  let t =
    {
      character = st.character;
      map_id = st.map_id;
      health = st.health;
      levelmap = "level";
      location = st.location;
      alive = true;
      fought = ene :: st.fought;
      usable = [];
      inventory = [];
    }
  in
  t

let health st = raise (Failure "Unimplemented")
let current_tile_id st = st.location

let move st x y =
  {
    character = st.character;
    map_id = st.map_id;
    health = st.health;
    levelmap = st.levelmap;
    location = (x, y);
    alive = st.alive;
    fought = st.fought;
    usable = [];
    inventory = [];
  }

(*not done, probably needs a way to decide which battle it is
  entering *)
let battle st x y =
  {
    character = st.character;
    map_id = st.map_id;
    health = st.health;
    levelmap = "fight";
    location = (x, y);
    alive = st.alive;
    fought = st.fought;
    usable = [];
    inventory = [];
  }

(* hatchery is a new location, where u can get new characters by
   gatchaing for them. Not yet implemented *)
let hatchary st x y =
  {
    character = st.character;
    map_id = st.map_id;
    health = st.health;
    levelmap = "hatchary";
    location = (x, y);
    alive = st.alive;
    fought = st.fought;
    usable = st.usable;
    inventory = st.inventory;
  }

(* obtainchar is for when u obtain a new character from the hatchery.
   Not yet implemented!!! *)
let obtainchar st chara =
  {
    character = st.character;
    map_id = st.map_id;
    health = st.health;
    levelmap = st.levelmap;
    location = st.location;
    alive = st.alive;
    fought = st.fought;
    usable = chara :: st.usable;
    inventory = [];
  }

(* getitem is for when u obtain a new character from the hatchery. Not
   yet implemented!!! *)
let getitem st item =
  {
    character = st.character;
    map_id = st.map_id;
    health = st.health;
    levelmap = st.levelmap;
    location = st.location;
    alive = st.alive;
    fought = st.fought;
    usable = st.usable;
    inventory = item :: st.inventory;
  }
