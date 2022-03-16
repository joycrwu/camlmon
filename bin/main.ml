open Graphics

let flush_kp () =
  while key_pressed () do
    let _ = read_key () in
    ()
  done

let main () =
  Graphics.open_graph " 1500 x 1500";
  set_window_title "Title";
  Graphics.set_text_size 300;
  Graphics.moveto 50 500;
  Graphics.draw_string "Yo";
  Graphics.draw_circle 50 50 10

(** this code was copied from stackoverflow
    https://stackoverflow.com/questions/36263152/simple-ocaml-graphics-progam-that-close-before-its-window-is-displayed*)
let rec interactive () =
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 'p' then exit 0 else print_char event.key;
  Graphics.clear_graph ();
  Graphics.auto_synchronize true;
  interactive ()

(** https://stackoverflow.com/questions/6390631/ocaml-module-graphics-queuing-keypresses *)

let () = main ()
let () = interactive ()
let () = flush_kp ()