open Level
open Character
open Battle

type status =
  | Start
  | Level
  | Team
  | Battle
  | Hatchery
  | Endscreen of bool

type t = {
  team : Character.t list;
  health : int;
  level : Level.t;
  location : int * int;
  character_pool : Character.t list;
  status : status;
  num_levels : int;
}

(**STATE GETTER FUNCTIONS**)
let current_health st = st.health

let current_tile_id st = st.location

(** VERY JANKY HARDCODED MATH WILL FIX LATER MAYBE*)
let get_x st = st.location |> fst |> ( - ) 48 |> abs |> float_of_int

let get_y st = st.location |> snd |> ( - ) 48 |> abs |> float_of_int
let current_level st = st.level
let current_team st = st.team
let current_character_pool st = st.character_pool
let get_num_levels st = st.num_levels

(**END OF STATE GETTER FUNCTIONS**)

let init_state (lvl : Level.t) (starter : Character.t) =
  {
    team = [ starter ];
    level = lvl;
    health = get_hp starter;
    location = start_location lvl;
    character_pool = [ starter ];
    status = Start;
    num_levels = 1;
  }

(* let fought (st : t) ene = let t = { character = st.character; map_id
   = st.map_id; health = st.health; levelmap = "level"; location =
   st.location; alive = true; fought = ene :: st.fought; usable = [];
   inventory = []; } in t *)

let move st (x : int) (y : int) = { st with location = (x, y) }

let new_level st lvl =
  {
    st with
    level = lvl;
    location = start_location lvl;
    num_levels = st.num_levels + 1;
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
    st with
    character_pool =
      (if List.exists (fun x -> x = ch) st.character_pool then
       st.character_pool
      else ch :: st.character_pool);
  }

(*team is the set of characters that the player chooses to use in a
  battle. Not yeet implemented.*)

let add_to_team st (ch : Character.t) =
  if List.length st.team < 3 then { st with team = [ ch ] @ st.team }
  else st

let remove_from_team st (ch : Character.t) =
  if List.length st.team > 0 then
    { st with team = List.filter (fun x -> x <> ch) st.team }
  else st

let change_hp st (change : int) =
  { st with health = st.health + change }

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

let status st = st.status
let to_battle st = { st with status = Battle }
let to_level st = { st with status = Level }
let to_team st = { st with status = Team }
let to_hatchery st = { st with status = Hatchery }
let to_endscreen st win = { st with status = Endscreen win }
