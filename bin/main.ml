open Graphics

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
  print_newline ();
  interactive ()

let () = main ()
let () = interactive ()
