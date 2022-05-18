open Game
open Raylib

let _ = Random.self_init ()
let windowWidth = 1632
let windowHeight = 960

(** https://stackoverflow.com/questions/6390631/ocaml-module-graphics-queuing-keypresses *)
let bat_backgroud () =
  clear_background (Color.create 230 251 255 255);
  draw_rectangle 0 0 1632 30 (Color.create 29 146 252 100);
  draw_rectangle 0 40 1632 30 (Color.create 29 146 252 100);
  draw_rectangle 0 80 1632 30 (Color.create 25 161 239 100);
  draw_rectangle 0 120 1632 30 (Color.create 25 161 239 100);
  draw_rectangle 0 160 1632 30 (Color.create 21 177 223 100);
  draw_rectangle 0 200 1632 30 (Color.create 21 177 223 100);
  draw_rectangle 0 240 1632 30 (Color.create 17 189 213 100);
  draw_rectangle 0 280 1632 30 (Color.create 17 189 213 100);
  draw_rectangle 0 320 1632 30 (Color.create 17 189 213 100);
  draw_rectangle 0 360 1632 30 (Color.create 17 189 213 100);
  draw_rectangle 0 400 1632 30 (Color.create 17 189 213 100);
  draw_rectangle 0 440 1632 30 (Color.create 8 216 185 100);
  draw_rectangle 0 480 1632 30 (Color.create 8 216 185 100);
  draw_rectangle 0 520 1632 30 (Color.create 7 225 177 100);
  draw_rectangle 0 560 1632 30 (Color.create 7 225 177 100);
  draw_rectangle 0 600 1632 30 (Color.create 36 216 150 100);
  draw_rectangle 0 640 1632 30 (Color.create 36 216 150 100);
  draw_rectangle 0 680 1632 30 (Color.create 7 197 123 100);
  draw_rectangle 0 720 1632 30 (Color.create 7 197 123 100);
  draw_rectangle 0 760 1632 30 (Color.create 4 135 69 100);
  draw_rectangle 0 800 1632 30 (Color.create 4 135 69 100)

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

let draw_battle_enemy char =
  let opp2 =
    Raylib.load_texture
      (String.lowercase_ascii ("assets/" ^ char ^ ".png"))
  in
  Raylib.draw_texture_rec opp2
    (Rectangle.create 0. 0. 300. 300.)
    (Vector2.create 1050. 100.)
    Color.white

(* "assets/girl_run_large.png" *)
let draw_battle_char chara =
  let opp1 =
    Raylib.load_texture
      (String.lowercase_ascii ("assets/" ^ chara ^ ".png"))
  in
  Raylib.draw_texture_rec opp1
    (Rectangle.create 0. 0. 300. 300.)
    (Vector2.create 250. 500.)
    Color.white

let box_battext () =
  draw_rectangle 100 100 600 300 (Color.create 248 248 216 255);
  draw_rectangle 920 480 600 300 (Color.create 248 248 216 255)

let health_bar_ally bat () =
  let character = Battle.character bat in
  let character_maxhp = float_of_int (Character.get_hp character) in
  let character_currhp = float_of_int (Battle.character_hp bat) in
  let percent_health = character_currhp /. character_maxhp in
  let num_health = int_of_float (percent_health *. 100.) in
  if num_health > Character.get_hp character then
    Raylib.draw_rectangle 170 300 300 20 Color.red
  else Raylib.draw_rectangle 170 300 num_health 20 Color.red

let health_bar_enemy bat () =
  let enemy = Battle.enemy bat in
  let enemy_maxhp = float_of_int (Character.get_hp enemy) in
  let enemy_currhp = float_of_int (Battle.enemy_hp bat) in
  let percent_health = enemy_currhp /. enemy_maxhp in
  let num_health = int_of_float (percent_health *. 100.) in
  if num_health > Character.get_hp enemy then
    Raylib.draw_rectangle 1000 680 300 20 Color.red
  else Raylib.draw_rectangle 1000 680 num_health 20 Color.red

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
  health_bar_ally bat ();
  health_bar_enemy bat ();
  Raylib.draw_text
    ("Ally " ^ (bat |> Game.Battle.character |> Game.Character.get_id))
    170 190 40 Color.black;
  draw_battle_char
    (bat |> Game.Battle.character |> Game.Character.get_id);
  Raylib.draw_text
    ("HP: " ^ string_of_int (Game.Battle.character_hp bat))
    170 240 40 Color.black;
  Raylib.draw_text
    ("Team: "
    ^ (bat |> Game.Battle.team
      |> List.map (fun x -> Game.Character.get_id x)
      |> print_list))
    100 600 50 Color.black;
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
    1000 570 40 Color.red;
  draw_battle_enemy (bat |> Game.Battle.enemy |> Game.Character.get_id);
  Raylib.draw_text
    ("HP: " ^ string_of_int (Game.Battle.enemy_hp bat))
    1000 620 40 Color.black

(** not currently functional*)
let draw_failed_run () =
  Raylib.draw_rectangle 0 0 600 500 (Color.create 100 100 0 0);
  Raylib.draw_text "You failed to run away" 250 200 10000
    (Color.create 0 0 255 0)

let victory_text () =
  Raylib.set_window_title "Victory";
  Raylib.draw_rectangle 0 0 windowWidth windowHeight Color.green;
  Raylib.draw_text "Poggers!" (windowWidth / 2) (windowHeight / 2) 50
    Color.black;
  Raylib.draw_text "Press enter to continue" (windowWidth / 2)
    ((windowHeight / 2) + 50)
    50 Color.black

let lose_text () =
  set_window_title "Game Over";
  Raylib.draw_rectangle 0 0 600 500 Color.black;
  Raylib.draw_rectangle 0 0 windowWidth windowHeight Color.red;
  Raylib.draw_text "Sadge D:" (windowWidth / 2) (windowHeight / 2) 50
    Color.black;
  Raylib.draw_text "Press enter to continue" (windowWidth / 2)
    ((windowHeight / 2) + 50)
    50 Color.black

let rec print_numbered_list (list : string list) (num : int) =
  match list with
  | h :: t ->
      if List.length list > 1 then
        Int.to_string num ^ h ^ ", " ^ print_numbered_list t (num + 1)
      else h
  | [] -> "none"

let rec card_distributor
    ()
    (startx : int)
    (starty : int)
    (counter : int)
    (row : int) =
  draw_rectangle startx starty 40 40 (Color.create 69 67 65 255);
  begin_drawing ();
  Raylib.draw_text
    (string_of_int (10 - (counter + row)))
    (startx + 10) (starty + 5) 30 Color.white;
  draw_rectangle (startx + 75) (starty + 10) 180 220
    (Color.create 140 138 133 255);
  draw_rectangle (startx + 65) starty 180 220
    (Color.create 168 166 160 255);
  if counter > 1 then
    card_distributor () (startx + 360) starty (counter - 1) row
  else ()

let rec team_card_dist () (startx : int) (starty : int) (counter : int)
    =
  draw_rectangle (startx + 70) (starty + 10) 180 220
    (Color.create 173 193 201 255);
  draw_rectangle (startx + 60) starty 180 220
    (Color.create 202 227 237 255);
  if counter > 1 then
    team_card_dist () (startx + 300) starty (counter - 1)
  else ()

let team_screen () st =
  set_window_title "Team Select";
  clear_background (Color.create 224 224 144 255);
  card_distributor () 115 30 5 5;
  card_distributor () 120 320 5 0;
  draw_rectangle 0 570 2000 260 (Color.create 219 168 116 255);
  Raylib.draw_text "Team: " 100 630 80 Color.red;
  draw_rectangle 600 775 600 10 (Color.create 184 134 83 255);
  team_card_dist () 500 585 3;
  draw_rectangle 0 820 2000 220 Color.white

let rec pool_no_team (pool : Character.t list) (team : Character.t list)
    =
  match pool with
  | h :: t ->
      if List.length (List.find_all (fun x -> x = h) team) = 0 then
        [ h ] @ pool_no_team t team
      else pool_no_team t team
  | _ -> pool

let draw_teampool_char chara startx starty =
  let lowercase = String.lowercase_ascii chara in
  let char = Raylib.load_texture ("assets/" ^ lowercase ^ ".png") in
  Raylib.draw_texture_rec char
    (Rectangle.create 0. 0. 150. 200.)
    (Vector2.create startx starty)
    Color.white

let rec pool_images
    ()
    (pool : Character.t list)
    (startx : float)
    (starty : float)
    (team : bool) =
  match pool with
  | h :: t ->
      draw_teampool_char (Character.get_id h) startx starty;
      if team = false then pool_images () t (startx +. 360.) starty team
      else pool_images () t (startx +. 300.) starty team
  | _ -> ()

let rec firstn n lst =
  match lst with
  | [] -> []
  | h :: t -> if n = 1 then [ h ] else h :: firstn (n - 1) t

let rec second_row lst =
  match lst with
  | h :: t ->
      if List.length (List.find_all (fun x -> x = h) (firstn 5 lst)) = 0
      then [ h ] @ second_row t
      else second_row t
  | [] -> []

let init_char_graphics () (st : State.t) =
  let team = State.current_team st in
  let pool = pool_no_team (State.current_character_pool st) team in
  if List.length pool = 0 then
    Raylib.draw_text "No new \nunlocks" 193 70 40 Color.black
  else if List.length pool < 6 then pool_images () pool 193. 43. false
  else pool_images () (firstn 5 pool) 193. 43. false;
  pool_images () (second_row pool) 193. 43. false;
  pool_images () team 575. 595. true

let team_text () st =
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
  Raylib.draw_text "Press 0-9 to add and Q-E to remove characters!" 100
    855 30 Color.black;
  Raylib.draw_text "Press B to battle!" 100 895 30 Color.black

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

let charArraystr =
  Sys.readdir ("data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep)

let timer = ref 0.

let cloud_screen (title : string) (action : string) (white : bool) =
  let open Raylib in
  begin_drawing ();
  clear_background Color.raywhite;
  draw_rectangle 0 0 1632 960 (Color.create 78 173 245 255);
  timer := Raylib.get_time () *. 3.;
  let cloudlocation () = if !timer < 100. then !timer else 0. in
  let opp2 =
    Raylib.load_texture (String.lowercase_ascii "assets/clouds.png")
  in
  if white then (
    let color = Color.white in
    Raylib.draw_texture_rec opp2
      (Rectangle.create 0. 0. 1600. 1600.)
      (Vector2.create (cloudlocation ()) 0.)
      color;
    Raylib.draw_text title 410 60 150 Color.black;
    Raylib.draw_text action 540 600 40 Color.black)
  else
    let color = Color.red in
    Raylib.draw_texture_rec opp2
      (Rectangle.create 0. 0. 1600. 1600.)
      (Vector2.create (cloudlocation ()) 0.)
      color;
    Raylib.draw_text title 410 60 150 Color.black;
    Raylib.draw_text action 540 600 40 Color.black

let rec endscreen_wait (st : State.t) (win : bool) =
  match Raylib.window_should_close () with
  | true ->
      Raylib.close_window ();
      st
  | false ->
      if win then cloud_screen "YOU WIN!" "PRESS ENTER TO RESTART" win
      else cloud_screen "GAME OVER" "PRESS ENTER TO RESTART" win;
      if Raylib.is_key_pressed Key.Enter then (
        end_drawing ();
        let lvl = Level.random_level in
        let c =
          "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
          ^ Array.get charArraystr 0
          |> Yojson.Basic.from_file |> Game.Character.from_json
        in
        State.init_state lvl c)
      else (
        end_drawing ();
        endscreen_wait st win)

let rec battle_wait (st : State.t) bat (team : bool) =
  match Raylib.window_should_close () with
  | true ->
      Raylib.close_window ();
      st
  | false ->
      begin_drawing ();
      clear_background Color.raywhite;
      if team then
        let char_input = Raylib.get_key_pressed () in
        if Battle.overbool bat then
          match Game.Command.team_add_remove char_input with
          | _ -> State.to_level st
        else (
          clear_background Color.raywhite;
          team_screen () st;
          team_text () st;
          init_char_graphics () st;
          match Command.team_add_remove char_input with
          | Add c ->
              end_drawing ();
              if
                List.length
                  (pool_no_team
                     (State.current_character_pool st)
                     (State.current_team st))
                < c + 1
              then battle_wait st bat true
              else
                battle_wait
                  (State.add_to_team st
                     (List.nth
                        (pool_no_team
                           (State.current_character_pool st)
                           (State.current_team st))
                        c))
                  bat true
          | Remove c ->
              end_drawing ();
              if List.length (State.current_team st) < c + 1 then
                battle_wait st bat true
              else
                battle_wait
                  (State.remove_from_team st
                     (List.nth (State.current_team st) c))
                  bat true
          | Battle ->
              if List.length (State.current_team st) > 0 then
                battle_wait st bat false
              else battle_wait st bat true
          | Unavailable ->
              end_drawing ();
              battle_wait st bat true)
      else
        let player_input = Raylib.get_key_pressed () in
        if Battle.overbool bat then
          if Character.get_id (Battle.enemy bat) = "Dijkstra" then
            State.to_endscreen st (Battle.wonbool bat)
          else (
            draw_exit_battle bat;
            match player_input with
            | Key.Enter ->
                end_drawing ();
                State.to_level st
            | _ ->
                end_drawing ();
                battle_wait st bat false)
        else (
          bat_backgroud ();
          battle_platform ();
          bottom_bar ();
          box_battext ();
          draw_battle_text bat ();
          let character = Game.Battle.character bat in
          let enemy = Game.Battle.enemy bat in
          match
            Game.Command.battle_input bat character player_input
          with
          | Attack x ->
              end_drawing ();
              (bat
              |> Game.Battle.character_turn
                   (Game.Character.get_action_effect character x)
              |> Game.Battle.enemy_turn
                   (Game.Character.get_action_effect enemy
                      (Random.int 3))
              |> battle_wait st)
                false
          | Run ->
              if Game.Battle.character_hp bat < Game.Battle.enemy_hp bat
              then
                if Random.bool () then State.to_level st
                else
                  (draw_failed_run ();
                   end_drawing ();
                   bat
                   |> Game.Battle.enemy_turn
                        (Game.Character.get_action_effect enemy
                           (Random.int 3))
                   |> battle_wait st)
                    false
              else if
                Random.int 100
                < Game.Battle.character_hp bat
                  - Game.Battle.enemy_hp bat
                  + 50
              then State.to_level st
              else
                (draw_failed_run ();
                 bat
                 |> Game.Battle.enemy_turn
                      (Game.Character.get_action_effect enemy
                         (Random.int 3))
                 |> battle_wait st)
                  false
          | Exit ->
              end_drawing ();
              exit 0
          | Invalid_input ->
              end_drawing ();
              battle_wait st bat false)

let i_to_char i =
  "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
  ^ Array.get charArraystr i
  |> Yojson.Basic.from_file |> Game.Character.from_json

let arrInd array element =
  let i = ref (-1) in
  let () =
    Array.iteri
      (fun n elt -> if element = elt then i := n else ())
      array
  in
  !i

let boss =
  "data" ^ Filename.dir_sep ^ "boss" ^ Filename.dir_sep
  ^ "dijkstra.json"
  |> Yojson.Basic.from_file |> Game.Character.from_json

let random (lst : Character.t list) =
  List.nth lst (Random.int (List.length lst))

let charArray =
  Array.map (fun x -> i_to_char (arrInd charArraystr x)) charArraystr

let fullpool =
  Array.map
    (fun x ->
      "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep ^ x
      |> Yojson.Basic.from_file |> Game.Character.from_json)
    charArraystr

let chara i st = List.nth (State.current_team st) i
let enemy i = Array.get fullpool i

let battle_start st =
  set_window_title "Battle";
  if State.get_num_levels st < 4 then
    let bat =
      Game.Battle.init_battle
        (random (State.current_team st))
        charArray.(Random.int (Array.length charArray))
        (State.current_team st)
    in
    battle_wait st bat
  else
    let final_bat =
      Game.Battle.init_battle (chara 0 st) boss (State.current_team st)
    in
    battle_wait st final_bat

(**HATCHERY DRAWING AND HATCHERY BIG RECURSION**)
let hatchery_background () =
  draw_ellipse 800 500 400. 100. (Color.create 224 224 144 255);
  draw_ellipse 800 500 370. 90. (Color.create 152 224 152 255);
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

let draw_hatchery_output_text () =
  (* draw_text text pos_x pos_y font_size color *)
  draw_triangle (Vector2.create 0. 0.)
    (Vector2.create 50. 100.)
    (Vector2.create 100. 0.)
    (Color.create 255 212 204 155);
  draw_triangle
    (Vector2.create 100. 0.)
    (Vector2.create 150. 100.)
    (Vector2.create 200. 0.)
    (Color.create 255 217 179 255);
  draw_triangle
    (Vector2.create 200. 0.)
    (Vector2.create 250. 100.)
    (Vector2.create 300. 0.)
    (Color.create 255 212 204 155);
  draw_triangle
    (Vector2.create 300. 0.)
    (Vector2.create 350. 100.)
    (Vector2.create 400. 0.)
    (Color.create 255 217 179 255);
  draw_triangle
    (Vector2.create 400. 0.)
    (Vector2.create 450. 100.)
    (Vector2.create 500. 0.)
    (Color.create 255 212 204 155);
  draw_triangle
    (Vector2.create 500. 0.)
    (Vector2.create 550. 100.)
    (Vector2.create 600. 0.)
    (Color.create 255 217 179 255);
  draw_triangle
    (Vector2.create 600. 0.)
    (Vector2.create 650. 100.)
    (Vector2.create 700. 0.)
    (Color.create 255 212 204 155);
  draw_triangle
    (Vector2.create 700. 0.)
    (Vector2.create 750. 100.)
    (Vector2.create 800. 0.)
    (Color.create 255 217 179 255);
  draw_triangle
    (Vector2.create 800. 0.)
    (Vector2.create 850. 100.)
    (Vector2.create 900. 0.)
    (Color.create 255 212 204 155);
  draw_triangle
    (Vector2.create 900. 0.)
    (Vector2.create 950. 100.)
    (Vector2.create 1000. 0.)
    (Color.create 255 217 179 255);
  draw_triangle
    (Vector2.create 1000. 0.)
    (Vector2.create 1050. 100.)
    (Vector2.create 1100. 0.)
    (Color.create 255 212 204 155);
  draw_triangle
    (Vector2.create 1100. 0.)
    (Vector2.create 1150. 100.)
    (Vector2.create 1200. 0.)
    (Color.create 255 217 179 255);
  draw_triangle
    (Vector2.create 1200. 0.)
    (Vector2.create 1250. 100.)
    (Vector2.create 1300. 0.)
    (Color.create 255 212 204 155);
  draw_triangle
    (Vector2.create 1300. 0.)
    (Vector2.create 1350. 100.)
    (Vector2.create 1400. 0.)
    (Color.create 255 217 179 255);
  draw_triangle
    (Vector2.create 1400. 0.)
    (Vector2.create 1450. 100.)
    (Vector2.create 1500. 0.)
    (Color.create 255 212 204 155);
  draw_triangle
    (Vector2.create 1500. 0.)
    (Vector2.create 1550. 100.)
    (Vector2.create 1600. 0.)
    (Color.create 255 217 179 255);
  draw_triangle
    (Vector2.create 400. 650.)
    (Vector2.create 0. 500.)
    (Vector2.create 0. 800.)
    (Color.create 255 255 153 255);
  draw_triangle
    (Vector2.create 1632. 500.)
    (Vector2.create 1232. 650.)
    (Vector2.create 1632. 800.)
    (Color.create 255 255 153 255);
  draw_triangle
    (Vector2.create 400. 350.)
    (Vector2.create 0. 200.)
    (Vector2.create 0. 500.)
    (Color.create 255 255 153 255);
  draw_triangle
    (Vector2.create 400. 350.)
    (Vector2.create 0. 200.)
    (Vector2.create 0. 500.)
    (Color.create 255 255 153 255);
  draw_triangle
    (Vector2.create 1632. 200.)
    (Vector2.create 1232. 350.)
    (Vector2.create 1632. 500.)
    (Color.create 255 255 153 255);
  draw_triangle
    (Vector2.create 400. 300.)
    (Vector2.create 0. 150.)
    (Vector2.create 0. 450.)
    (Color.create 255 153 153 200);
  draw_triangle
    (Vector2.create 1632. 150.)
    (Vector2.create 1232. 300.)
    (Vector2.create 1632. 450.)
    (Color.create 255 153 153 200);
  draw_triangle
    (Vector2.create 400. 600.)
    (Vector2.create 0. 450.)
    (Vector2.create 0. 750.)
    (Color.create 255 153 153 200);
  draw_triangle
    (Vector2.create 1632. 450.)
    (Vector2.create 1232. 600.)
    (Vector2.create 1632. 750.)
    (Color.create 255 153 153 200);
  (* rgb() *)
  Raylib.draw_text "Congratulations on your new character!" 80 750 50
    Color.black;
  Raylib.draw_text "Press 1 or 2 to move on!" 1120 870 30 Color.black

let draw_gacha_output (s1 : string) (s2 : string) =
  Raylib.draw_text s1 40 40 40 Color.black;
  Raylib.draw_text s2 40 80 40 Color.black

let initx = ref 0.
let inity = ref 0.

let level_start st =
  set_window_title "Level";
  initx := State.get_x st;
  inity := State.get_y st

let move_on_from_hatchery st =
  end_drawing ();
  let level_with_new_char = State.to_level st in
  let next_level_st =
    State.new_level level_with_new_char
      (level_with_new_char |> State.current_level |> Level.next_level)
  in
  match State.get_num_levels next_level_st < 4 with
  | true -> next_level_st
  | false ->
      let final_boss_st = State.to_battle next_level_st in
      battle_start final_boss_st true

let draw_gacha_char char =
  let lowercase = String.lowercase_ascii char in
  let ch = Raylib.load_texture ("assets/" ^ lowercase ^ ".png") in
  Raylib.draw_texture_rec ch
    (Rectangle.create 0. 0. 300. 300.)
    (Vector2.create 680. 200.)
    Color.white

let rec hatchery_endscreen_wait (st : State.t) =
  set_window_title "New Character!";
  match Raylib.window_should_close () with
  | true ->
      Raylib.close_window ();
      st
  | false -> (
      (let open Raylib in
      begin_drawing ();
      clear_background Color.raywhite;
      hatchery_background ();
      hatchery_bottom_bar ();
      draw_hatchery_output_text ();
      let currpool_array =
        Array.of_list (State.current_character_pool st)
      in
      let new_chara = Array.get currpool_array 0 in
      let new_chara_name = Character.get_id new_chara in
      draw_gacha_char new_chara_name;
      let new_chara_rarity = Character.get_rarity new_chara in
      match new_chara_rarity with
      | 1 -> draw_gacha_output new_chara_name "Normal"
      | 2 -> draw_gacha_output new_chara_name "Rare"
      | 3 -> draw_gacha_output new_chara_name "SSR"
      | _ -> failwith "something went wrong");
      let player_input = Raylib.get_key_pressed () in
      match Command.hatchery_input player_input with
      | Roll -> move_on_from_hatchery st
      | Skip -> move_on_from_hatchery st
      | Invalid ->
          end_drawing ();
          hatchery_endscreen_wait st)

let rec gacha_and_check (st : State.t) (hat : Hatchery.t) =
  let gacha_output = Hatchery.gacha hat in
  if
    List.exists
      (fun x -> x = gacha_output)
      (State.current_character_pool st)
  then gacha_and_check st hat
  else State.new_playable_char st gacha_output

let rec hatchery_wait (st : State.t) (hat : Hatchery.t) =
  set_window_title "Hatchery";
  match Raylib.window_should_close () with
  | true ->
      Raylib.close_window ();
      st
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
          end_drawing ();
          let new_playable_char_state = gacha_and_check st hat in
          hatchery_endscreen_wait new_playable_char_state
      | Skip -> move_on_from_hatchery st
      | Invalid ->
          (* Raylib.draw_text "Try again!" 700 835 50 Color.black; *)
          end_drawing ();
          hatchery_wait st hat)

let create_hatchery hat =
  let pathstring =
    "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
  in
  let all_character_pathway =
    List.map (fun x -> pathstring ^ x) (Array.to_list charArraystr)
  in
  let all_character_json_list =
    List.map Yojson.Basic.from_file all_character_pathway
  in
  let all_character_list =
    List.map Character.from_json all_character_json_list
  in
  List.fold_left Hatchery.add_char_to_pool hat all_character_list

let hatchery_start st =
  set_window_title "Hatchery";
  let empty_hatchery = Hatchery.new_hatchery () in
  create_hatchery empty_hatchery

let move_distance = 24
let tile_size = 96
let randomBattleProbability = 10
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
      let lvl = Game.State.current_level st in
      let location = Game.State.current_tile_id st in
      let player_input = Raylib.get_key_pressed () in
      (* Game.Command.map_input ( *)
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
                if randomBattleGen then battle_start st true
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
                let hatchery_state = State.to_hatchery st in
                let new_hatchery = hatchery_start st in
                hatchery_wait hatchery_state new_hatchery)
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
                if randomBattleGen then battle_start st true
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
                let hatchery_state = State.to_hatchery st in
                let new_hatchery = hatchery_start st in
                hatchery_wait hatchery_state new_hatchery)
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
                if randomBattleGen then battle_start st true
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
                let hatchery_state = State.to_hatchery st in
                let new_hatchery = hatchery_start st in
                hatchery_wait hatchery_state new_hatchery)
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
                if randomBattleGen then battle_start st true
                  (*truncate*)
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
                let hatchery_state = State.to_hatchery st in
                let new_hatchery = hatchery_start st in
                hatchery_wait hatchery_state new_hatchery
          (* let st' = Game.State.new_level st (st |>
             State.current_level |> Level.next_level) in level_start
             st'; level_wait st') *))
      | Battle ->
          end_drawing ();
          battle_start st true
      | Exit ->
          end_drawing ();
          exit 0
      | Hatchery ->
          end_drawing ();
          hatchery_wait st (Hatchery.new_hatchery ())
      | _ ->
          Raylib.end_drawing ();
          level_wait st)
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
      cloud_screen "POKEML" "PRESS ENTER TO START" true;
      if Raylib.is_key_pressed Key.Enter then (
        end_drawing ();
        State.to_level st)
      else (
        end_drawing ();
        start_wait st)

let rec wait st =
  match State.status st with
  | Start -> wait (start_wait st)
  | Level ->
      level_start st;
      wait (level_wait st)
  | Endscreen b -> wait (endscreen_wait st b)
  | _ -> wait st

let main () =
  Raylib.init_window windowWidth windowHeight
    "raylib [core] example - basic window";
  Raylib.set_target_fps 60;
  let lvl = Level.random_level in
  let c =
    "data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
    ^ Array.get charArraystr 0
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
