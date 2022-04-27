open Graphics
open Raylib
open Yojson.Basic.Util

(* let _ = Random.self_init () *)
let tile_width = 96
let tile_height = 96

type tile =
  | Grass
  | Water
  | Road

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
  grid : tile array array;
  level_id : string;
  width : int;
  height : int;
}

(* let from_json json = { grid = json |> member "tiles" |> to_list |>
   List.map (string list); level_id = json |> member "id" |> to_string;
   width = json |> member "width" |> to_int; height = json |> member
   "height" |> to_int; } *)

let get_characterid lvl = "lvl.current_character"
let start_location lvl = (48, 48)
let get_map lvl = lvl.level_id

let create_grid width height =
  Array.init width (fun _ ->
      Array.init height (fun _ ->
          if Random.bool () then Road
          else if Random.bool () then Water
          else Grass))

let init_lvl width height =
  { grid = create_grid width height; level_id = "test"; width; height }

let get_tile x y lvl = Array.get (Array.get lvl.grid y) x
let set_tile x y lvl tile = Array.set (Array.get lvl.grid y) x tile

(* taken from somewhere *)
let load path =
  let tex = Raylib.load_texture path in
  Gc.finalise Raylib.unload_texture tex;
  tex

let gtilewidth = 96.
let gtileheight = 48.

let draw_lvl lvl =
  let ground = load "assets/ground.png" in
  (* let water = load "assets/ground.png" in let road = load
     "assets/ground.png" in *)
  for i = 0 to lvl.width - 1 do
    for j = 0 to lvl.height - 1 do
      match get_tile i j lvl with
      | Grass ->
          Raylib.draw_texture_rec ground
            (Rectangle.create 0. gtileheight gtilewidth gtilewidth)
            (Vector2.create
               (float_of_int (i * tile_width))
               (float_of_int (j * tile_width)))
            Color.white
      | Water ->
          Raylib.draw_texture_rec ground
            (Rectangle.create (gtilewidth *. 3.) (gtileheight *. 7.)
               gtilewidth gtilewidth)
            (Vector2.create
               (float_of_int (i * tile_width))
               (float_of_int (j * tile_width)))
            Color.white
      | Road ->
          Raylib.draw_texture_rec ground
            (Rectangle.create (gtilewidth *. 1.) (gtileheight *. 1.)
               gtilewidth gtilewidth)
            (Vector2.create
               (float_of_int (i * tile_width))
               (float_of_int (j * tile_width)))
            Color.white
    done
  done
(* Graphics.set_color (rgb 128 170 255); Graphics.fill_rect 0 0 600 90;
   Graphics.set_color (rgb 179 242 255); Graphics.fill_rect 10 5 280 80;
   Graphics.set_color (rgb 179 242 255); Graphics.fill_rect 310 5 280
   80; Graphics.set_color (rgb 0 0 0); Graphics.moveto 400 65;
   Graphics.draw_string "Press WASD to move"; Graphics.moveto 400 40;
   Graphics.draw_string "Press f to fight"; Graphics.moveto 400 15;
   Graphics.draw_string "Press q to quit" *)
