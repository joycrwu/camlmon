open Graphics
open Game

let flush_kp () =
  while key_pressed () do
    let _ = read_key () in
    ()
  done

let main () =
  Graphics.open_graph "";
  set_window_title "Title";
  Graphics.set_text_size 300;
  Graphics.moveto 50 500;
  Graphics.draw_string "Yo";
  Graphics.draw_circle 50 50 10

(** this code was copied from stackoverflow
    https://stackoverflow.com/questions/36263152/simple-ocaml-graphics-progam-that-close-before-its-window-is-displayed*)
let rec interactive () =
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 'q' then exit 0 else print_char event.key;
  Graphics.clear_graph ();
  Graphics.auto_synchronize true;
  interactive ()

(** https://stackoverflow.com/questions/6390631/ocaml-module-graphics-queuing-keypresses *)

let () = main ()
let () = interactive ()
let () = flush_kp ()

let rec wait (bat : Battle.t) =
  let character = Game.Battle.character bat in
  let player_input = Game.Command.input bat character in
  match player_input with
  | Attack x -> Game.Battle.character_turn bat x
  | Run ->
      flush_kp ();
      wait bat
  | Invalid_input ->
      flush_kp ();
      wait bat

let victory_text () =
  Graphics.open_graph "";
  set_window_title "Victory";
  Graphics.set_text_size 100;
  Graphics.moveto 50 500;
  Graphics.draw_string "Poggers!"

let exit_battle (bat : Battle.t) =
  if Game.Battle.wonbattle bat then victory_text ()
