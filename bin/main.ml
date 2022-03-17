open Graphics
open Game

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

let victory_text () =
  Graphics.open_graph "";
  set_window_title "Victory";
  Graphics.set_color (rgb 255 255 0);
  Graphics.fill_rect 0 0 600 500;
  Graphics.set_color (rgb 0 0 255);
  Graphics.set_text_size 10000000;
  Graphics.moveto 250 200;
  Graphics.draw_string "Poggers!";
  Graphics.sound 740 500;
  Graphics.sound 622 500;
  Graphics.sound 659 500;
  Graphics.sound 988 500;
  Graphics.sound 932 500;
  Graphics.sound 988 500

let exit_battle (bat : Battle.t) =
  if Game.Battle.wonbattle bat then victory_text ()

let rec wait (bat : Battle.t) =
  Graphics.clear_graph ();
  exit_battle bat;
  flush_kp ();
  Graphics.set_color (rgb 0 0 0);
  Graphics.moveto 50 70;
  Graphics.draw_string
    ("Ally " ^ (bat |> Game.Battle.character |> Game.Character.get_id));
  Graphics.moveto 400 140;
  Graphics.draw_string
    ("Press 1 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 0);
  Graphics.moveto 400 110;
  Graphics.draw_string
    ("Press 2 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 1);
  Graphics.moveto 400 80;
  Graphics.draw_string
    ("Press 3 for "
    ^ Game.Character.get_action (Game.Battle.character bat) 2);
  Graphics.moveto 400 50;
  Graphics.draw_string "Press r to run!";
  Graphics.moveto 450 370;
  Graphics.draw_string
    ("Enemy " ^ (bat |> Game.Battle.enemy |> Game.Character.get_id));
  Graphics.set_color (rgb 255 0 0);
  Graphics.moveto 50 50;
  Graphics.draw_string
    ("HP: " ^ string_of_int (Game.Battle.character_hp bat));
  Graphics.moveto 450 350;
  Graphics.draw_string
    ("HP: " ^ string_of_int (Game.Battle.enemy_hp bat));

  let character = Game.Battle.character bat in
  let player_input = Game.Command.input bat character in
  match player_input with
  | Attack x -> wait (Game.Battle.character_turn bat x)
  | Run -> exit 0
  | Invalid_input -> wait bat

let main () =
  Graphics.open_graph " 1500 x 1500";
  set_window_title "Title";
  let bat =
    Game.Battle.init_battle
      ("data" ^ Filename.dir_sep ^ "larry.json"
      |> Yojson.Basic.from_file |> Game.Character.from_json)
      ("data" ^ Filename.dir_sep ^ "dinoplant.json"
      |> Yojson.Basic.from_file |> Game.Character.from_json)
  in
  wait bat

let () = main ()
let () = interactive ()
let () = flush_kp ()