(* open Graphics *)
open Game
open Raylib

(* old stuff *)

let _ = Random.self_init ()

(* let flush_kp () = while key_pressed () do let _ = read_key () in ()
   done *)

(** this code was copied from stackoverflow
    https://stackoverflow.com/questions/36263152/simple-ocaml-graphics-progam-that-close-before-its-window-is-displayed*)

(* let rec interactive () = let event = wait_next_event [ Key_pressed ]
   in if event.key == 'p' then exit 0 else print_char event.key;
   Graphics.clear_graph (); Graphics.auto_synchronize true; interactive
   () *)

(** https://stackoverflow.com/questions/6390631/ocaml-module-graphics-queuing-keypresses *)
(* let bottom_bar () = Graphics.open_graph ""; Graphics.set_color (rgb
   230 251 255); Graphics.fill_rect 0 90 600 490; Graphics.set_color
   (rgb 0 153 230); Graphics.fill_rect 20 420 560 10; Graphics.set_color
   (rgb 25 178 255); Graphics.fill_rect 20 400 560 10;
   Graphics.set_color (rgb 77 195 255); Graphics.fill_rect 20 380 560
   10; Graphics.set_color (rgb 128 212 255); Graphics.fill_rect 20 360
   560 10; Graphics.set_color (rgb 153 221 255); Graphics.fill_rect 20
   340 560 10; Graphics.set_color (rgb 153 221 255); Graphics.fill_rect
   20 320 560 10; Graphics.set_color (rgb 179 229 255);
   Graphics.fill_rect 20 300 560 10; Graphics.set_color (rgb 204 238
   255); Graphics.fill_rect 20 280 560 10; Graphics.set_color (rgb 204
   238 255); Graphics.fill_rect 20 260 560 10; Graphics.set_color (rgb
   204 238 255); Graphics.fill_rect 20 240 560 10; Graphics.set_color
   (rgb 204 238 255); Graphics.fill_rect 20 220 560 10;
   Graphics.set_color (rgb 204 238 255); Graphics.fill_rect 20 200 560
   10; Graphics.set_color (rgb 204 238 255); Graphics.fill_rect 20 180
   560 10; Graphics.set_color (rgb 204 238 255); Graphics.fill_rect 20
   160 560 10; Graphics.set_color (rgb 204 238 255); Graphics.fill_rect
   20 140 560 10; Graphics.set_color (rgb 230 247 255);
   Graphics.fill_rect 20 120 560 10; Graphics.set_color (rgb 230 247
   255); Graphics.fill_rect 20 100 560 10; Graphics.set_color (rgb 255
   186 82); Graphics.fill_ellipse 150 95 140 60; Graphics.set_color (rgb
   255 186 82); Graphics.fill_ellipse 460 270 140 60; Graphics.set_color
   (rgb 128 170 255); Graphics.fill_rect 0 0 600 90; Graphics.set_color
   (rgb 179 242 255); Graphics.fill_rect 10 5 280 80; Graphics.set_color
   (rgb 179 242 255); Graphics.fill_rect 310 5 280 80;
   Graphics.set_color (rgb 0 0 0) *)

let health_bar_ally bat () =
  (* Graphics.open_graph ""; *)
  let character = Battle.character bat in
  let character_maxhp = float_of_int (Character.get_hp character) in
  let character_currhp = float_of_int (Battle.character_hp bat) in
  let percent_health = character_currhp /. character_maxhp in
  let num_health = int_of_float (percent_health *. 100.) in
  if num_health > Character.get_hp character then
    Raylib.draw_rectangle 50 115 100 10 Color.black
  else Raylib.draw_rectangle 50 115 num_health 10 Color.black

let health_bar_enemy bat () =
  (* Graphics.open_graph ""; *)
  let enemy = Battle.enemy bat in
  let enemy_maxhp = float_of_int (Character.get_hp enemy) in
  let enemy_currhp = float_of_int (Battle.enemy_hp bat) in
  let percent_health = enemy_currhp /. enemy_maxhp in
  let num_health = int_of_float (percent_health *. 100.) in
  if num_health > Character.get_hp enemy then
    (* (Graphics.set_color (rgb 0 0 0); Graphics.fill_rect 450 390 100
       10) *)
    Raylib.draw_rectangle 450 390 100 10 Color.black
  else
    (* (Graphics.set_color (rgb 0 0 0); Graphics.fill_rect 450 390
       num_health 10) *)
    Raylib.draw_rectangle 450 390 num_health 10 Color.black

let rec print_list (list : string list) =
  match list with
  | h :: t ->
      if List.length list > 1 then h ^ ", " ^ print_list t else h
  | [] -> "none"

let draw_battle_text bat () =
  (* Graphics.set_color (rgb 0 0 0); *)
  (* bottom_bar (); *)
  health_bar_ally bat ();
  health_bar_enemy bat ();
  (* draw_text text pos_x pos_y font_size color *)
  Raylib.draw_text
    ("Ally " ^ (bat |> Game.Battle.character |> Game.Character.get_id))
    50 100 20 Color.black;
  Raylib.draw_text
    ("Team: "
    ^ (bat |> Game.Battle.team
      |> List.map (fun x -> Game.Character.get_id x)
      |> print_list))
    50 370 20 Color.black;
  Raylib.draw_text
    ("Press 1 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 0)
    315 60 20 Color.black;
  Raylib.draw_text
    ("Press 2 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 1)
    315 40 20 Color.black;
  Raylib.draw_text
    ("Press 3 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 2)
    315 20 20 Color.black;
  Raylib.draw_text "Press r to run!" 485 55 20 Color.black;
  Raylib.draw_text "Press q to quit" 485 25 20 Color.black;
  Raylib.draw_text
    ("Enemy " ^ (bat |> Game.Battle.enemy |> Game.Character.get_id))
    450 370 20 Color.red;
  Raylib.draw_text
    ("HP: " ^ string_of_int (Game.Battle.character_hp bat))
    50 90 20 Color.black;
  Raylib.draw_text
    ("HP: " ^ string_of_int (Game.Battle.enemy_hp bat))
    450 350 20 Color.black

(** not currently functional*)
let draw_failed_run () =
  Raylib.draw_rectangle 0 0 600 500 (Color.create 100 100 0 0);
  Raylib.draw_text "You failed to run away" 250 200 10000
    (Color.create 0 0 255 0)

let victory_text () =
  Raylib.set_window_title "Victory";
  Raylib.draw_text "Poggers!" 250 200 10000 Color.green
(* Graphics.set_color (rgb 0 255 0); Graphics.fill_rect 0 0 600 500;
   Graphics.set_color (rgb 0 0 255); Graphics.set_text_size 10000000;
   Graphics.moveto 250 200; Graphics.draw_string "Poggers!" *)

let lose_text () =
  (* Graphics.open_graph ""; *)
  set_window_title "Game Over";
  Raylib.draw_rectangle 0 0 600 500 Color.black;
  Raylib.draw_text "Sadge D:" 250 200 10000 Color.red

let exit_battle bat =
  if Game.Battle.wonbattle bat then victory_text ()
  else if Game.Battle.losebattle bat then lose_text ()

let rec wait (bat : Battle.t) =
  exit_battle bat;
  (* flush_kp (); *)
  draw_battle_text bat ();
  let character = Game.Battle.character bat in
  let enemy = Game.Battle.enemy bat in
  let player_input = Raylib.get_char_pressed in
  match Game.Command.battle_input bat character (player_input ()) with
  | Attack x ->
      bat
      |> Game.Battle.character_turn x
      |> Game.Battle.enemy_turn
           (Game.Character.get_action_effect enemy (Random.int 3))
      |> wait
  | Run ->
      if Game.Battle.character_hp bat < Game.Battle.enemy_hp bat then
        if Random.bool () then exit 0
        else (
          draw_failed_run ();
          bat
          |> Game.Battle.enemy_turn
               (Game.Character.get_action_effect enemy (Random.int 3))
          |> wait)
      else if
        Random.int 100
        < Game.Battle.character_hp bat - Game.Battle.enemy_hp bat + 50
      then exit 0
      else (
        draw_failed_run ();
        bat
        |> Game.Battle.enemy_turn
             (Game.Character.get_action_effect enemy (Random.int 3))
        |> wait)
  | Exit -> exit 0
  | Invalid_input -> wait bat

let charArray =
  Sys.readdir ("data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep)

let randomChar1 =
  charArray |> Array.length |> Random.int |> Array.get charArray

let randomChar2 =
  charArray |> Array.length |> Random.int |> Array.get charArray

let randomChar3 =
  charArray |> Array.length |> Random.int |> Array.get charArray

let battle_start () =
  set_window_title "Battle";
  let bat =
    Game.Battle.init_battle
      ("data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
       ^ randomChar1
      |> Yojson.Basic.from_file |> Game.Character.from_json)
      ("data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
       ^ randomChar2
      |> Yojson.Basic.from_file |> Game.Character.from_json)
      ([
         "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
         ^ randomChar1
         |> Yojson.Basic.from_file |> Game.Character.from_json;
       ]
      @ [
          "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
          ^ randomChar3
          |> Yojson.Basic.from_file |> Game.Character.from_json;
        ])
  in
  wait bat

let rec map_wait st lvl =
  (* Graphics.clear_graph (); flush_kp (); *)
  Game.Level.draw_lvl lvl;
  let location = Game.State.current_tile_id st in
  Raylib.draw_circle (fst location) (snd location) 5. Color.red;
  let player_input = Raylib.get_char_pressed in
  match Game.Command.map_input (player_input ()) with
  | Up -> (
      let x = fst location in
      let y = snd location + 10 in
      match Game.Level.get_tile (x / 96) (y / 96) lvl with
      | Grass -> map_wait (Game.State.move st x y) lvl
      | Water ->
          map_wait
            (Game.State.move st (fst location) (snd location))
            lvl
      | Road -> map_wait (Game.State.move st x y) lvl)
  | Down -> (
      let x = fst location in
      let y = snd location - 10 in
      match Game.Level.get_tile (x / 10) (y / 10) lvl with
      | Grass -> map_wait (Game.State.move st x y) lvl
      | Water ->
          map_wait
            (Game.State.move st (fst location) (snd location))
            lvl
      | Road -> map_wait (Game.State.move st x y) lvl)
  | Left -> (
      let x = fst location - 10 in
      let y = snd location in
      match Game.Level.get_tile (x / 10) (y / 10) lvl with
      | Grass -> map_wait (Game.State.move st x y) lvl
      | Water ->
          map_wait
            (Game.State.move st (fst location) (snd location))
            lvl
      | Road -> map_wait (Game.State.move st x y) lvl)
  | Right -> (
      let x = fst location + 10 in
      let y = snd location in
      match Game.Level.get_tile (x / 10) (y / 10) lvl with
      | Grass -> map_wait (Game.State.move st x y) lvl
      | Water ->
          map_wait
            (Game.State.move st (fst location) (snd location))
            lvl
      | Road -> map_wait (Game.State.move st x y) lvl)
  | Exit -> exit 0
  | Invalid_input -> battle_start

(* let main () = let lvl = Game.Level.init_lvl 100 100 in
   Game.Level.draw_lvl lvl; let c = "data" ^ Filename.dir_sep ^ "char" ^
   Filename.dir_sep ^ randomChar1 |> Yojson.Basic.from_file |>
   Game.Character.from_json in map_wait (Game.State.init_state lvl c)
   lvl *)

(* let main () = Graphics.open_graph " 1500 x 1500"; set_window_title
   "Title"; let lvl = Game.Level.init_lvl 100 100 in Game.Level.draw_lvl
   lvl; let c = "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep ^
   randomChar1 |> Yojson.Basic.from_file |> Game.Character.from_json in
   map_wait (Game.State.init_state lvl c) lvl *)
let setup () =
  Raylib.init_window 1720 1000 "raylib [core] example - basic window";
  let lvl = Game.Level.init_lvl 100 100 in
  Game.Level.draw_lvl lvl;
  Raylib.set_target_fps 60

let rec loop () =
  match Raylib.window_should_close () with
  | true -> Raylib.close_window ()
  | false ->
      let open Raylib in
      begin_drawing ();
      (* clear_background Color.raywhite; *)
      end_drawing ();
      loop ()

let () = setup () |> loop

(* let () = setup () |> loop *)
(* let () = interactive () let () = flush_kp () *)
