open Graphics

let main () =
  Graphics.open_graph "";
  set_window_title "Title";
  Graphics.set_text_size 300;
  Graphics.moveto 50 500;
  Graphics.draw_string "Yo";
  Graphics.draw_circle 50 50 10

let () = main ()