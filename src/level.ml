open Graphics
open Raylib

let _ = Random.self_init ()
let tile_width = 10
let tile_height = 10

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

let get_characterid lvl = "lvl.current_character"
let start_location lvl = (5, 115)
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

let draw_lvl lvl =
  for i = 0 to lvl.width - 1 do
    for j = 9 to lvl.height - 1 do
      match get_tile i j lvl with
      | Grass ->
          Graphics.set_color green;
          Graphics.fill_rect (i * tile_width) (j * tile_width)
            tile_width tile_height
      | Water ->
          Graphics.set_color blue;
          Graphics.fill_rect (i * tile_width) (j * tile_width)
            tile_width tile_height
      | Road ->
          Graphics.set_color white;
          Graphics.fill_rect (i * tile_width) (j * tile_width)
            tile_width tile_height
    done
  done;
  Graphics.set_color (rgb 128 170 255);
  Graphics.fill_rect 0 0 600 90;
  Graphics.set_color (rgb 179 242 255);
  Graphics.fill_rect 10 5 280 80;
  Graphics.set_color (rgb 179 242 255);
  Graphics.fill_rect 310 5 280 80;
  Graphics.set_color (rgb 0 0 0);
  Graphics.moveto 400 65;
  Graphics.draw_string "Press WASD to move";
  Graphics.moveto 400 40;
  Graphics.draw_string "Press f to fight";
  Graphics.moveto 400 15;
  Graphics.draw_string "Press q to quit"
