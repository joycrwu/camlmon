open Level
open Character
open Battle

type t = {
  character : Character.t;
  map_id : string;
  health : int;
  inbattle : bool;
  location : int * int;
  alive : bool;
  fought : string list;
}

let current_character st = raise (Failure "Unimplemented")

let init_state (lvl : Level.t) =
  let t =
    {
      character = current_character lvl;
      map_id = get_map lvl;
      health = get_health lvl;
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
let current_tile_id st = raise (Failure "Unimplemented")
