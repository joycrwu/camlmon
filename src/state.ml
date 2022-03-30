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
  inbattle : bool;
  location : int * int;
  alive : bool;
  fought : string list;
}

let init_state (lvl : Level.t) character =
  let t =
    {
      character;
      map_id = get_map lvl;
      health = 0;
      inbattle = false;
      location = start_location lvl;
      alive = true;
      fought = [];
    }
  in
  t

let fought (st : t) ene =
  let t =
    {
      character = st.character;
      map_id = st.map_id;
      health = st.health;
      inbattle = false;
      location = st.location;
      alive = true;
      fought = ene :: st.fought;
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
    inbattle = st.inbattle;
    location = (x, y);
    alive = st.alive;
    fought = st.fought;
  }