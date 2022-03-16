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
  Graphics.set_text_size 1000;
  Graphics.moveto 25 25;
  Graphics.draw_string "Poggers!"

let exit_battle (bat : Battle.t) =
  if Game.Battle.wonbattle bat then victory_text ()

let rec wait (bat : Battle.t) =
  Graphics.clear_graph ();
  exit_battle bat;
  flush_kp ();
  Graphics.moveto 50 50;
  Graphics.draw_string (string_of_int (Game.Battle.character_hp bat));
  Graphics.moveto 10 10;
  Graphics.draw_string (string_of_int (Game.Battle.enemy_hp bat));
  let character = Game.Battle.character bat in
  let player_input = Game.Command.input bat character in
  match player_input with
  | Attack x -> wait (Game.Battle.character_turn bat x)
  | Run -> wait bat
  | Invalid_input -> wait bat

let main () =
  Graphics.open_graph " 1500 x 1500";
  set_window_title "Title";
  wait
    (Game.Battle.init_battle
       ("data" ^ Filename.dir_sep ^ "larry.json"
       |> Yojson.Basic.from_file |> Game.Character.from_json)
       ("data" ^ Filename.dir_sep ^ "larry.json"
       |> Yojson.Basic.from_file |> Game.Character.from_json))

let () = main ()
let () = interactive ()
let () = flush_kp ()