open Game
open Raylib

(* old stuff *)

let _ = Random.self_init ()

(* Graphics.set_color (rgb 0 153 230); Graphics.fill_rect 20 420 560 10;
   Graphics.set_color (rgb 25 178 255); Graphics.fill_rect 20 400 560
   10; Graphics.set_color (rgb 77 195 255); Graphics.fill_rect 20 380
   560 10; Graphics.set_color (rgb 128 212 255); Graphics.fill_rect 20
   360 560 10; Graphics.set_color (rgb 153 221 255); Graphics.fill_rect
   20 340 560 10; Graphics.set_color (rgb 153 221 255);
   Graphics.fill_rect 20 320 560 10; Graphics.set_color (rgb 179 229
   255); Graphics.fill_rect 20 300 560 10; Graphics.set_color (rgb 204
   238 255); Graphics.fill_rect 20 280 560 10; Graphics.set_color (rgb
   204 238 255); Graphics.fill_rect 20 260 560 10; Graphics.set_color
   (rgb 204 238 255); Graphics.fill_rect 20 240 560 10;
   Graphics.set_color (rgb 204 238 255); Graphics.fill_rect 20 220 560
   10; Graphics.set_color (rgb 204 238 255); Graphics.fill_rect 20 200
   560 10; Graphics.set_color (rgb 204 238 255); Graphics.fill_rect 20
   180 560 10; Graphics.set_color (rgb 204 238 255); Graphics.fill_rect
   20 160 560 10; Graphics.set_color (rgb 204 238 255);
   Graphics.fill_rect 20 140 560 10; Graphics.set_color (rgb 230 247
   255); Graphics.fill_rect 20 120 560 10; Graphics.set_color (rgb 230
   247 255); Graphics.fill_rect 20 100 560 10; *)
(* let bottom_bar () = Graphics.open_graph ""; Graphics.set_color (rgb
   230 251 255); Graphics.fill_rect 0 90 600 490; Graphics.set_color
   (rgb 128 170 255); Graphics.fill_rect 0 0 600 90; Graphics.set_color
   (rgb 179 242 255); Graphics.fill_rect 10 5 280 80; Graphics.set_color
   (rgb 179 242 255); Graphics.fill_rect 310 5 280 80;
   Graphics.set_color (rgb 0 0 0) *)

(** https://stackoverflow.com/questions/6390631/ocaml-module-graphics-queuing-keypresses *)
let bat_backgroud () =
  clear_background (Color.create 230 251 255 255);
  draw_rectangle 0 0 1632 10 Color.gray

let bottom_bar () =
  draw_rectangle 0 800 1632 200 (Color.create 72 64 80 255);
  draw_rectangle 26 820 776 140 (Color.create 104 160 160 255);
  draw_rectangle 829 820 776 140 (Color.create 179 242 255 255)

let battle_platform () =
  draw_ellipse 400 800 400. 100. (Color.create 224 224 144 255);
  draw_ellipse 1200 350 400. 100. (Color.create 224 224 144 255);
  draw_ellipse 400 800 370. 90. (Color.create 152 224 152 255);
  draw_ellipse 1200 350 370. 90. (Color.create 152 224 152 255);

  (* 3 dot row upper right*)
  draw_rectangle 1320 300 10 10 (Color.create 168 232 168 255);
  draw_rectangle 1335 300 10 10 (Color.create 168 232 168 255);
  draw_rectangle 1350 300 10 10 (Color.create 224 224 144 255);
  draw_rectangle 1400 360 10 10 (Color.create 168 232 168 255);
  draw_rectangle 1415 360 10 10 (Color.create 168 232 168 255);
  draw_rectangle 1430 360 10 10 (Color.create 224 224 144 255);
  draw_rectangle 1000 360 10 10 (Color.create 224 224 144 255);
  draw_rectangle 1015 360 10 10 (Color.create 168 232 168 255);
  draw_rectangle 1030 360 10 10 (Color.create 168 232 168 255);
  (* 3 dot row lower left*)
  draw_rectangle 520 730 10 10 (Color.create 168 232 168 255);
  draw_rectangle 535 730 10 10 (Color.create 168 232 168 255);
  draw_rectangle 550 730 10 10 (Color.create 224 224 144 255);
  draw_rectangle 600 790 10 10 (Color.create 168 232 168 255);
  draw_rectangle 615 790 10 10 (Color.create 168 232 168 255);
  draw_rectangle 630 790 10 10 (Color.create 224 224 144 255);
  draw_rectangle 150 790 10 10 (Color.create 224 224 144 255);
  draw_rectangle 165 790 10 10 (Color.create 168 232 168 255);
  draw_rectangle 180 790 10 10 (Color.create 168 232 168 255)

let box_battext () =
  draw_rectangle 26 100 600 300 (Color.create 248 248 216 255);
  draw_rectangle 829 520 600 300 (Color.create 248 248 216 255)

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

let draw_map_text () =
  Raylib.draw_text "MOVEMENT:" 50 870 30 Color.black;
  Raylib.draw_text "W - UP" 300 830 30 Color.black;
  Raylib.draw_text "A - LEFT" 300 860 30 Color.black;
  Raylib.draw_text "S - DOWN" 300 890 30 Color.black;
  Raylib.draw_text "D - RIGHT" 300 920 30 Color.black;

  Raylib.draw_text "B - ENTER BATTLE" 1000 830 30 Color.black;
  Raylib.draw_text "Q - QUIT" 1000 860 30 Color.black

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
    1300 700 20 Color.black;
  Raylib.draw_text
    ("Press 1 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 0)
    100 835 30 Color.black;
  Raylib.draw_text
    ("Press 2 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 1)
    100 875 30 Color.black;
  Raylib.draw_text
    ("Press 3 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 2)
    100 915 30 Color.black;
  Raylib.draw_text "Press r to run!" 1000 850 30 Color.black;
  Raylib.draw_text "Press q to quit" 1000 890 30 Color.black;
  Raylib.draw_text
    ("Enemy " ^ (bat |> Game.Battle.enemy |> Game.Character.get_id))
    1150 600 30 Color.red;
  Raylib.draw_text
    ("HP: " ^ string_of_int (Game.Battle.character_hp bat))
    50 90 30 Color.black;
  Raylib.draw_text
    ("HP: " ^ string_of_int (Game.Battle.enemy_hp bat))
    1150 640 30 Color.black

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

let rec print_numbered_list (list : string list) (num : int) =
  match list with
  | h :: t ->
      if List.length list > 1 then
        Int.to_string num ^ h ^ ", " ^ print_numbered_list t (num + 1)
      else h
  | [] -> "none"

let teambuilder () st =
  set_window_title "Team Select";
  Raylib.draw_rectangle 0 0 600 500 Color.yellow;
  Raylib.draw_text
    ("Characters: "
    ^ print_numbered_list
        (List.map
           (fun x -> x |> Game.Character.get_id)
           (State.current_character_pool st))
        0)
    250 200 10000 Color.black;
  Raylib.draw_text
    ("Team: "
    ^ print_list
        (List.map
           (fun x -> x |> Game.Character.get_id)
           (State.current_team st)))
    750 700 10000 Color.black;
  Raylib.draw_text
    "To add or remove, press a or r, then the number of the character!"
    100 835 30 Color.black;
  Raylib.draw_text "Press B to battle!" 100 875 30 Color.black

let draw_exit_battle bat =
  if Game.Battle.wonbool bat then victory_text ()
  else if Game.Battle.losebool bat then lose_text ()
  else ()

type direction =
  | Up
  | Down
  | Left
  | Right

let direct = ref Down

let rec battle_wait (st : State.t) bat =
  match Raylib.window_should_close () with
  | true ->
      Raylib.close_window ();
      st
  | false -> (
      draw_exit_battle bat;
      begin_drawing ();
      clear_background Color.raywhite;
      bat_backgroud ();
      battle_platform ();
      bottom_bar ();
      box_battext ();
      draw_battle_text bat ();
      let character = Game.Battle.character bat in
      let enemy = Game.Battle.enemy bat in
      let player_input = Raylib.get_key_pressed () in
      if Battle.overbool bat then
        match Game.Command.battle_input bat character player_input with
        | _ -> State.to_level st
      else
        match Game.Command.battle_input bat character player_input with
        | Attack x ->
            end_drawing ();
            bat
            |> Game.Battle.character_turn x
            |> Game.Battle.enemy_turn
                 (Game.Character.get_action_effect enemy (Random.int 3))
            |> battle_wait st
        | Run ->
            if Game.Battle.character_hp bat < Game.Battle.enemy_hp bat
            then
              if Random.bool () then exit 0
              else (
                draw_failed_run ();
                end_drawing ();
                bat
                |> Game.Battle.enemy_turn
                     (Game.Character.get_action_effect enemy
                        (Random.int 3))
                |> battle_wait st)
            else if
              Random.int 100
              < Game.Battle.character_hp bat
                - Game.Battle.enemy_hp bat
                + 50
            then exit 0
            else (
              draw_failed_run ();
              bat
              |> Game.Battle.enemy_turn
                   (Game.Character.get_action_effect enemy
                      (Random.int 3))
              |> battle_wait st)
        | Exit ->
            end_drawing ();
            exit 0
        | Invalid_input ->
            end_drawing ();
            battle_wait st bat)

let charArray =
  Sys.readdir ("data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep)

let i_to_char i =
  "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
  ^ Array.get charArray i
  |> Yojson.Basic.from_file |> Game.Character.from_json

(**HATCHERY DRAWING AND HATCHERY BIG RECURSION**)
let hatchery_background () =
  clear_background (Color.create 230 251 255 255);
  draw_rectangle 0 0 1632 10 Color.gray

let hatchery_bottom_bar () =
  draw_rectangle 0 800 1632 200 (Color.create 72 64 80 255);
  draw_rectangle 26 820 776 140 (Color.create 104 160 160 255);
  draw_rectangle 829 820 776 140 (Color.create 179 242 255 255)

let draw_hatchery_text () =
  (* draw_text text pos_x pos_y font_size color *)
  Raylib.draw_text "Welcome to the Hatchery!" 80 835 50 Color.black;
  Raylib.draw_text "Press 1 to roll" 1120 870 30 Color.black;
  Raylib.draw_text "Press 2 to skip" 1120 900 30 Color.black

let rec hatchery_wait (st : State.t) (hat : Hatchery.t) =
  match Raylib.window_should_close () with
  | true -> Raylib.close_window ()
  | false -> (
      (let open Raylib in
      begin_drawing ();
      clear_background Color.raywhite;
      hatchery_background ();
      hatchery_bottom_bar ();
      draw_hatchery_text ());
      let player_input = Raylib.get_key_pressed () in
      match Command.hatchery_input player_input with
      | Roll ->
          let new_char = Hatchery.gacha hat in
          let new_state = State.new_playable_char st new_char in
          let new_hatchery = Hatchery.character_outputs new_char hat in
          end_drawing ();
          hatchery_wait new_state new_hatchery
      | Skip ->
          end_drawing ();
          hatchery_wait st hat
      | Invalid ->
          (* Raylib.draw_text "Try again!" 700 835 50 Color.black; *)
          end_drawing ();
          hatchery_wait st hat)

let create_hatchery hat =
  let all_character_json_list =
    List.map Yojson.Basic.from_file (Array.to_list charArray)
  in
  let all_character_list =
    List.map Character.from_json all_character_json_list
  in
  List.fold_left Hatchery.add_char_to_pool hat all_character_list

let hatchery_start st =
  set_window_title "Hatchery";
  let empty_hatchery = Hatchery.new_hatchery () in
  let charpool_hatchery = create_hatchery empty_hatchery in
  hatchery_wait st charpool_hatchery

let fullpool =
  Array.map
    (fun x ->
      "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep ^ x
      |> Yojson.Basic.from_file |> Game.Character.from_json)
    charArray

let chara i team = List.nth (Team.get_team_characters team) i
let enemy i = Array.get fullpool i

let battle_start st team =
  set_window_title "Battle";
  let bat =
    Game.Battle.init_battle (chara 0 team) (enemy 2) [ chara 0 team ]
  in
  battle_wait st bat

let initx = ref 0.
let inity = ref 0.
let move_distance = 24
let tile_size = 96
let randomBattleProbability = 10
let windowWidth = 1632
let windowHeight = 960
let tileHeight = (96 * 8) + 10
let up () : unit = inity := !inity -. float_of_int move_distance
let down () : unit = inity := !inity +. float_of_int move_distance
let left () : unit = initx := !initx -. float_of_int move_distance
let right () : unit = initx := !initx +. float_of_int move_distance

let femchard x y (dir : direction) =
  let chara = Raylib.load_texture "assets/girl_run_large.png" in
  match dir with
  | Up ->
      Raylib.draw_texture_rec chara
        (Rectangle.create 0.
           (3. *. (410. /. 4.))
           (410. /. 4.) (410. /. 4.))
        (Vector2.create x y) Color.white
  | Down ->
      Raylib.draw_texture_rec chara
        (Rectangle.create 0. 0. (410. /. 4.) (410. /. 4.))
        (Vector2.create x y) Color.white
  | Left ->
      Raylib.draw_texture_rec chara
        (Rectangle.create 0.
           (1. *. (410. /. 4.))
           (410. /. 4.) (410. /. 4.))
        (Vector2.create x y) Color.white
  | Right ->
      Raylib.draw_texture_rec chara
        (Rectangle.create 0.
           (2. *. (410. /. 4.))
           (410. /. 4.) (410. /. 4.))
        (Vector2.create x y) Color.white

let rec level_wait st =
  match Raylib.window_should_close () with
  | true ->
      Raylib.close_window ();
      st
  | false -> (
      let open Raylib in
      begin_drawing ();
      clear_background Color.raywhite;
      Game.Level.draw_lvl (State.current_level st);
      bottom_bar ();
      draw_map_text ();
      femchard !initx !inity !direct;
      Raylib.draw_text
        ("charloc:" ^ string_of_float !initx ^ ","
       ^ string_of_float !inity)
        0 0 40 Color.black;
      let lvl = Game.State.current_level st in
      let location = Game.State.current_tile_id st in
      let player_input = Raylib.get_key_pressed () in
      (* Game.Command.map_input ( *)
      Raylib.draw_text
        ("stateloc:"
        ^ string_of_int (fst location)
        ^ ","
        ^ string_of_int (snd location))
        0 50 40 Color.black;
      let randomBattleGen = Random.int 100 < randomBattleProbability in
      match Command.map_input player_input with
      | Up -> (
          direct := Up;
          let x = fst location in
          let y = snd location - move_distance in
          if x < 0 || y < 0 || x >= windowWidth || y >= windowHeight
          then level_wait st
          else
            match
              Game.Level.get_tile (x / tile_size) (y / tile_size) lvl
            with
            | Grass ->
                up ();
                end_drawing ();
                if randomBattleGen then
                  battle_start st (Game.Team.init_team (i_to_char 1))
                else level_wait (Game.State.move st x y)
            | Water ->
                end_drawing ();
                level_wait st
            | Road ->
                up ();
                end_drawing ();
                level_wait (Game.State.move st x y)
            | Exit ->
                up ();
                end_drawing ();
                level_wait (Game.State.move st x y))
      | Down -> (
          direct := Down;
          let x = fst location in
          let y = snd location + move_distance in
          if x < 0 || y < 0 || x >= windowWidth || y >= tileHeight then
            level_wait st
          else
            match
              Game.Level.get_tile (x / tile_size) (y / tile_size) lvl
            with
            | Grass ->
                down ();
                end_drawing ();
                if randomBattleGen then
                  battle_start st (Game.Team.init_team (i_to_char 1))
                else level_wait (Game.State.move st x y)
            | Water ->
                end_drawing ();
                level_wait st
            | Road ->
                down ();
                end_drawing ();
                level_wait (Game.State.move st x y)
            | Exit ->
                down ();
                end_drawing ();
                level_wait (Game.State.move st x y))
      | Left -> (
          direct := Left;
          let x = fst location - move_distance in
          let y = snd location in
          if x < 0 || y < 0 || x >= windowWidth || y >= tileHeight then
            level_wait st
          else
            match
              Game.Level.get_tile (x / tile_size) (y / tile_size) lvl
            with
            | Grass ->
                left ();
                end_drawing ();
                if randomBattleGen then
                  battle_start st (Game.Team.init_team (i_to_char 1))
                else level_wait (Game.State.move st x y)
            | Water ->
                end_drawing ();
                level_wait st
            | Road ->
                left ();
                end_drawing ();
                level_wait (Game.State.move st x y)
            | Exit ->
                left ();
                end_drawing ();
                level_wait (Game.State.move st x y))
      | Right -> (
          direct := Right;
          let x = fst location + move_distance in
          let y = snd location in
          if x < 0 || y < 0 || x >= windowWidth || y >= tileHeight then
            level_wait st
          else
            match
              Game.Level.get_tile (x / tile_size) (y / tile_size) lvl
            with
            | Grass ->
                right ();
                end_drawing ();
                if randomBattleGen then
                  battle_start st (Game.Team.init_team (i_to_char 1))
                else level_wait (Game.State.move st x y)
            | Water ->
                end_drawing ();
                level_wait st
            | Road ->
                right ();
                end_drawing ();
                level_wait (Game.State.move st x y)
            | Exit ->
                right ();
                end_drawing ();
                level_wait (Game.State.move st x y))
      | Battle ->
          end_drawing ();
          battle_start st (Game.Team.init_team (i_to_char 1))
      | Exit ->
          end_drawing ();
          exit 0
      (** | Hatchery ->
          end_drawing ();
          hatchery_wait st (Hatchery.new_hatchery ()) *)
      | _ ->
          Raylib.end_drawing ();
          level_wait st)

let level_start st =
  set_window_title "Level";
  initx := State.get_x st;
  inity := State.get_y st
(* | Exit -> end_drawing (); exit 0 | Invalid_input -> end_drawing ();
   battle_start ()) *)

(* let main () = let lvl = Game.Level.init_lvl 100 100 in
   Game.Level.draw_lvl lvl; let c = "data" ^ Filename.dir_sep ^ "char" ^
   Filename.dir_sep ^ randomChar1 |> Yojson.Basic.from_file |>
   Game.Character.from_json in map_wait (Game.State.init_state lvl c)
   lvl *)

let rec start_wait st =
  match Raylib.window_should_close () with
  | true ->
      Raylib.close_window ();
      st
  | false ->
      let open Raylib in
      begin_drawing ();
      clear_background Color.raywhite;
      Raylib.draw_text "hello, press enter to continue" 0 0 40
        Color.black;
      if Raylib.is_key_pressed Key.Enter then (
        end_drawing ();
        level_start st;
        State.to_level st)
      else (
        end_drawing ();
        start_wait st)

let rec wait st =
  match State.status st with
  | Start -> wait (start_wait st)
  | Level -> wait (level_wait st)
  | _ -> wait st

let main () =
  Raylib.init_window windowWidth windowHeight
    "raylib [core] example - basic window";
  Raylib.set_target_fps 60;
  let lvl =
    Level.random_level
  in
  let c =
    "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
    ^ Array.get charArray 0
    |> Yojson.Basic.from_file |> Game.Character.from_json
  in
  wait (Game.State.init_state lvl c)
(* (* duplicate code *) let load path = let tex = Raylib.load_texture
   path in Gc.finalise Raylib.unload_texture tex; tex *)

(* move loading textures to outside of this function *)
(* let rec loop () = match Raylib.window_should_close () with | true ->
   Raylib.close_window () | false -> let open Raylib in begin_drawing
   (); femchard !initx !inity; (* let key = get_key_pressed () in *) if
   is_key_down Key.D then right () else if is_key_down Key.W then up ()
   else if is_key_down Key.A then left () else if is_key_down Key.S then
   down () else if is_key_down Key.F then battle_start (); end_drawing
   (); loop () *)

let () = main ()
(* levels are 10 x 17 *)
(* let () = setup () |> loop *)
(* let () = interactive () let () = flush_kp () *)
