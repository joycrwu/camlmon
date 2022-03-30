open Graphics
open Game

let _ = Random.self_init ()

let flush_kp () =
  while key_pressed () do
    let _ = read_key () in
    ()
  done

(** this code was copied from stackoverflow
    https://stackoverflow.com/questions/36263152/simple-ocaml-graphics-progam-that-close-before-its-window-is-displayed*)

let rec interactive () =
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 'p' then exit 0 else print_char event.key;
  Graphics.clear_graph ();
  Graphics.auto_synchronize true;
  interactive ()

(** https://stackoverflow.com/questions/6390631/ocaml-module-graphics-queuing-keypresses *)
let bottom_bar () =
  Graphics.open_graph "";
  Graphics.set_color (rgb 230 251 255);
  Graphics.fill_rect 0 90 600 490;

  Graphics.set_color (rgb 255 186 82);
  Graphics.fill_ellipse 150 95 140 60;

  Graphics.set_color (rgb 255 186 82);
  Graphics.fill_ellipse 460 270 140 60;

  Graphics.set_color (rgb 128 170 255);
  Graphics.fill_rect 0 0 600 90;
  Graphics.set_color (rgb 179 242 255);
  Graphics.fill_rect 10 5 280 80;
  Graphics.set_color (rgb 179 242 255);
  Graphics.fill_rect 310 5 280 80;

  Graphics.set_color (rgb 0 0 0)

let rec print_list (list : string list) =
  match list with
  | h :: t ->
      if List.length list > 1 then h ^ ", " ^ print_list t else h
  | [] -> "none"

let draw_battle_text bat () =
  Graphics.set_color (rgb 0 0 0);
  bottom_bar ();
  Graphics.moveto 50 100;
  Graphics.draw_string
    ("Ally " ^ (bat |> Game.Battle.character |> Game.Character.get_id));
  Graphics.moveto 50 370;
  Graphics.draw_string
    ("Team: " ^ (bat |> Game.Battle.team |> print_list));
  Graphics.moveto 400 140;
  Graphics.moveto 315 60;
  Graphics.draw_string
    ("Press 1 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 0);
  Graphics.moveto 315 40;
  Graphics.draw_string
    ("Press 2 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 1);
  Graphics.moveto 315 20;
  Graphics.draw_string
    ("Press 3 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 2);
  Graphics.moveto 485 55;
  Graphics.draw_string "Press r to run!";
  Graphics.moveto 485 25;
  Graphics.draw_string "Press q to quit";
  Graphics.moveto 450 370;
  Graphics.draw_string
    ("Enemy " ^ (bat |> Game.Battle.enemy |> Game.Character.get_id));
  Graphics.set_color (rgb 255 0 0);
  Graphics.moveto 50 90;
  Graphics.draw_string
    ("HP: " ^ string_of_int (Game.Battle.character_hp bat));
  Graphics.moveto 450 350;
  Graphics.draw_string
    ("HP: " ^ string_of_int (Game.Battle.enemy_hp bat))

(** not currently functional*)
let draw_failed_run () =
  Graphics.open_graph "";
  Graphics.set_color (rgb 100 100 0);
  Graphics.fill_rect 0 0 600 500;
  Graphics.set_color (rgb 0 0 255);
  Graphics.set_text_size 10000000;
  Graphics.moveto 250 200;
  Graphics.draw_string "You failed to run away"

let victory_text () =
  Graphics.open_graph "";
  set_window_title "Victory";
  Graphics.set_color (rgb 0 255 0);
  Graphics.fill_rect 0 0 600 500;
  Graphics.set_color (rgb 0 0 255);
  Graphics.set_text_size 10000000;
  Graphics.moveto 250 200;
  Graphics.draw_string "Poggers!"

let lose_text () =
  Graphics.open_graph "";
  set_window_title "Game Over";
  Graphics.set_color (rgb 255 0 0);
  Graphics.fill_rect 0 0 600 500;
  Graphics.set_color (rgb 0 0 255);
  Graphics.set_text_size 10000000;
  Graphics.moveto 250 200;
  Graphics.draw_string "Sadge D:"

let exit_battle bat =
  if Game.Battle.wonbattle bat then victory_text ()
  else if Game.Battle.losebattle bat then lose_text ()

let rec wait (bat : Battle.t) =
  Graphics.clear_graph ();
  exit_battle bat;
  flush_kp ();
  draw_battle_text bat ();
  let character = Game.Battle.character bat in
  let enemy = Game.Battle.enemy bat in
  let player_input = Game.Command.battle_input bat character in
  match player_input with
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

<<<<<<< HEAD
let main2 () =
=======
let randomChar3 =
  charArray |> Array.length |> Random.int |> Array.get charArray

let main () =
>>>>>>> 867ed0fd012c3898035e9b40bd15c9047c540c68
  Graphics.open_graph " 1500 x 1500";
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
         Character.get_id
           ("data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
            ^ randomChar1
           |> Yojson.Basic.from_file |> Game.Character.from_json);
       ]
      @ [
          Character.get_id
            ("data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
             ^ randomChar3
            |> Yojson.Basic.from_file |> Game.Character.from_json);
        ])
  in
  wait bat

let rec map_wait st lvl =
  Graphics.clear_graph ();
  flush_kp ();
  Game.Level.draw_lvl lvl;
  let location = Game.State.current_tile_id st in
  Graphics.set_color red;
  Graphics.draw_circle (fst location) (snd location) 5;
  let player_input = Game.Command.map_input in
  match player_input with
  | Up ->
      let x = fst location in
      let y = snd location + 10 in
      map_wait (Game.State.move st x y) lvl
  | Down ->
      let x = fst location in
      let y = snd location - 10 in
      map_wait (Game.State.move st x y) lvl
  | Left ->
      let x = fst location - 10 in
      let y = snd location in
      map_wait (Game.State.move st x y) lvl
  | Right ->
      let x = fst location + 10 in
      let y = snd location in
      map_wait (Game.State.move st x y) lvl
  | Exit -> exit 0
  | Invalid_input -> map_wait st lvl

let main () =
  Graphics.open_graph " 1500 x 1500";
  set_window_title "Title";
  let lvl = Game.Level.init_lvl 100 100 in
  Game.Level.draw_lvl lvl;
  map_wait (Game.State.init_state lvl) lvl

let () = main ()
let () = interactive ()
let () = flush_kp ()