(** TEST PLAN
    Due to the game-like nature of our program, it was difficult to test all
    functions via OUnit. Many of our functionalities depended on a sequence of
    functions, or relied on player input, and thus much of the testing was 
    completed via "make play" rather than "make test." As a general rule, 
    raylib graphics, main functions, and the Command module had to be tested
    exclusively in "make play." On the other hand json reliant modules such as
    Character and Level, as well as general getter functions from modules like
    Hatchery, Battle, State and Team could be tested in OUnit.
  
    We approached testing based on each of the modules, so we
    have test cases written in a list for most of the modular content
    needed for our software. To begin, we tested many of the getter
    functions for the modules. We started with the ones that took in a
    json file, such as character. Since many of the type t's in the
    modules were implemented as records, we could check whether the
    getters were retrieving them correctly. From there, we tested some of
    the manipulator functions that would change the type t in each of the
    modules. Since the type t's cannot be accessed from outside of the
    module itself, we then used the getters again to test whether the type
    t was manipulated properly. The specific modules that we tested using
    OUnit include Battle, State, Level, Hatchery, and Character.
    
    Test cases were developed via black-box testing, or based on the specs of 
    the tested functions. Many of the testable functions were simple getter 
    functions and thus had few paths to run through. Our testing demonstrates 
    the correctness of our system because not only do we test that the 
    individual functionalities are working, we also tested with the GUI itself 
    which proves that each modular program works in conjunction. Many bugs
    could be identified via make play, then isolated and solved by make test. *)

open OUnit2
open Game
open Battle
open Character
open Hatchery

let larry = Yojson.Basic.from_file "data/char/larry.json" |> from_json

let dinoplant =
  Yojson.Basic.from_file "data/char/dinoplant.json" |> from_json

let healer = Yojson.Basic.from_file "data/char/healer.json" |> from_json
let tank = Yojson.Basic.from_file "data/char/tank.json" |> from_json
let camel = Yojson.Basic.from_file "data/char/camel.json" |> from_json

let (basiclevel : Level.t) =
  Yojson.Basic.from_file "data/level/basiclevel.json" |> Level.from_json

let (level2 : Level.t) =
  Yojson.Basic.from_file "data/level/level2.json" |> Level.from_json

let tile_size = 96

let get_id_test
    (name : string)
    (character : Character.t)
    (expected_output : string) : test =
  name >:: fun _ -> assert_equal expected_output (get_id character)

let get_hp_test
    (name : string)
    (character : Character.t)
    (expected_output : int) : test =
  name >:: fun _ -> assert_equal expected_output (get_hp character)

let get_atk_test
    (name : string)
    (character : Character.t)
    (expected_output : int) : test =
  name >:: fun _ -> assert_equal expected_output (get_atk character)

let get_affinity_test
    (name : string)
    (character : Character.t)
    (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (get_affinity character)

let aff_effect_test
    (name : string)
    (c : Character.t)
    (t : Character.t)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output
    (aff_effect c t [ "red"; "green"; "blue"; "green" ])

let get_partner_test
    (name : string)
    (character : Character.t)
    (expected_output : string) : test =
  name >:: fun _ -> assert_equal expected_output (get_partner character)

let get_partner_eff_test
    (name : string)
    (character : Character.t)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output (get_partner_effect character)

let char_list_test (name : string) (expected_output : string list) :
    test =
  name >:: fun _ ->
  assert_equal expected_output
    ("data" ^ Filename.dir_sep ^ "char" ^ Filename.dir_sep
    |> Sys.readdir |> Array.to_list)

let get_action_test
    (name : string)
    (character : Character.t)
    (which : int)
    (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (get_action character which)

let get_action_effect_test
    (name : string)
    (character : Character.t)
    (which : int)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output (get_action_effect character which)

let get_rarity_test
    (name : string)
    (character : Character.t)
    (expected_output : int) : test =
  name >:: fun _ -> assert_equal expected_output (get_rarity character)

(**Helper functions for battle test below*)
(* let init_battle_test (name : string) (character : Character.t) (enemy
   : Character.t) (team : Character.t list) (expected_output : Battle.t)
   : test = name >:: fun _ -> assert_equal expected_output (init_battle
   character enemy team) *)

let character_hp_test
    (name : string)
    (battle : Battle.t)
    (expected_output : int) =
  name >:: fun _ -> assert_equal expected_output (character_hp battle) ~printer:string_of_int

let enemy_hp_test
    (name : string)
    (battle : Battle.t)
    (expected_output : int) =
  name >:: fun _ -> assert_equal expected_output (enemy_hp battle) ~printer:string_of_int

let character_test
    (name : string)
    (battle : Battle.t)
    (expected_output : Character.t) =
  name >:: fun _ -> assert_equal expected_output (character battle)

let enemy_test
    (name : string)
    (battle : Battle.t)
    (expected_output : Character.t) =
  name >:: fun _ -> assert_equal expected_output (enemy battle)

let team_test
    (name : string)
    (battle : Battle.t)
    (expected_output : Character.t list) =
  name >:: fun _ -> assert_equal expected_output (team battle)

let overbool_test
    (name : string)
    (battle : Battle.t)
    (expected_output : bool) =
  name >:: fun _ -> assert_equal expected_output (overbool battle)

let wonbool_test
    (name : string)
    (battle : Battle.t)
    (expected_output : bool) =
  name >:: fun _ -> assert_equal expected_output (wonbool battle)

let losebool_test
    (name : string)
    (battle : Battle.t)
    (expected_output : bool) =
  name >:: fun _ -> assert_equal expected_output (losebool battle)

(**END BATTLE TESTS**)

(**START HATCHERY TESTS**)
let get_normalcharpool_test
    (name : string)
    (hat : Hatchery.t)
    (expected_output : Character.t list) : test =
  name >:: fun _ ->
  assert_equal expected_output (get_normal_char_pool hat)

let get_rarecharpool_test
    (name : string)
    (hat : Hatchery.t)
    (expected_output : Character.t list) : test =
  name >:: fun _ ->
  assert_equal expected_output (get_rare_char_pool hat)

let get_ssrcharpool_test
    (name : string)
    (hat : Hatchery.t)
    (expected_output : Character.t list) : test =
  name >:: fun _ -> assert_equal expected_output (get_ssr_char_pool hat)

(**END HATCHERY TESTS**)

(**START LEVEL TESTS**)

let get_map_test
    (name : string)
    (lvl : Level.t)
    (expected_output : string) : test =
  name >:: fun _ -> assert_equal expected_output (Level.get_map lvl)

let start_location_test
    (name : string)
    (lvl : Level.t)
    (expected_output : int * int) : test =
  name >:: fun _ ->
  assert_equal expected_output (Level.start_location lvl)

let get_tile_test
    (name : string)
    (lvl : Level.t)
    (x : int)
    (y : int)
    (expected_output : Level.tile) : test =
  name >:: fun _ ->
  assert_equal expected_output (Level.get_tile x y lvl)

let next_level_test
    (name : string)
    (lvl : Level.t)
    (expected_output : Level.t) : test =
  name >:: fun _ -> assert_equal expected_output (Level.next_level lvl)

(**END LEVEL TESTS**)

(**START STATE TESTS**)
let current_health_test
    (name : string)
    (st : State.t)
    (expected_output : int) =
  name >:: fun _ ->
  assert_equal expected_output (State.current_health st)

let current_tile_id_test
    (name : string)
    (st : State.t)
    (expected_output : int * int) : test =
  name >:: fun _ ->
  assert_equal expected_output (State.current_tile_id st)

let current_level_test
    (name : string)
    (st : State.t)
    (expected_output : Level.t) : test =
  name >:: fun _ ->
  assert_equal expected_output (State.current_level st)

let current_team_test
    (name : string)
    (st : State.t)
    (expected_output : Character.t list) : test =
  name >:: fun _ -> assert_equal expected_output (State.current_team st)

let current_character_pool_test
    (name : string)
    (st : State.t)
    (expected_output : Character.t list) : test =
  name >:: fun _ ->
  assert_equal expected_output (State.current_character_pool st)

let status_test
    (name : string)
    (st : State.t)
    (expected_output : State.status) =
  name >:: fun _ -> assert_equal expected_output (State.status st)

let character_tests =
  [
    get_id_test "Larry's Name" larry "Larry";
    get_id_test "Dinoplant's Name" dinoplant "Dinoplant";
    get_id_test "Healer's Name" healer "Healer";
    get_id_test "Tank's Name" tank "Tank";
    get_id_test "Camel's Name" camel "Camel";
    get_hp_test "Larry's Hp" larry 100;
    get_hp_test "Dinoplant's Hp" dinoplant 100;
    get_hp_test "Healer's HP" healer 100;
    get_hp_test "Tank's HP" tank 1000;
    get_hp_test "Camel's HP" camel 25;
    get_atk_test "Larry's attack" larry 10;
    get_atk_test "Dinoplant's attack" dinoplant 5;
    get_atk_test "Healer's Attack" healer 5;
    get_atk_test "Tank's Attack" tank 5;
    get_atk_test "Camel's Attack" camel 10;
    get_affinity_test "Larry's attack" larry "Cascadilla Hall";
    get_affinity_test "Dinoplant's attack" dinoplant "Grass";
    (* char_list_test "Character List" [ "larry.json"; "dinoplant.json";
       "healer.json" ]; *)
    (**aff_effect_test "Larry aff effect" larry dinoplant 2;
    aff_effect_test "Dinoplant aff effect" dinoplant larry (1 / 2); *)
    get_partner_test "Larry partner" larry "Bruiser";
    get_partner_test "Dinoplant partner" dinoplant "Healer";
    get_partner_eff_test "Larry partner" larry 3;
    get_partner_eff_test "Dinoplant partner" dinoplant 3;
    get_action_test "Larry's Thunderbolt" larry 0 "Thunderbolt";
    get_action_test "Larry's Fireball" larry 1 "Fireball";
    get_action_test "Larry's Ice Chain" larry 2 "Ice Chain";
    get_action_effect_test "Larry Thunderbolt - 2" larry 0 2;
    get_action_effect_test "Larry Fireball - 3" larry 1 3;
    get_action_effect_test "Larry Ice Chain - 1" larry 2 1;
    get_rarity_test "Larry rarity" larry 2;
    get_rarity_test "Dinoplant rarity" dinoplant 1;
  ]

let alpha_battle = init_battle larry dinoplant [ larry ]
let alpha_battle_won = wonbattle alpha_battle
let alpha_battle_lost = lostbattle alpha_battle
let alpha_battle_larryturn = character_turn 
(Character.get_action_effect larry 0) alpha_battle
let alpha_battle_dinoturn = enemy_turn 
(Character.get_action_effect dinoplant 0) alpha_battle_larryturn

let battle_tests =
  [
    character_hp_test "Larry HP - Alpha Battle" alpha_battle 100;
    character_hp_test "Larry HP - Alpha Battle Won" alpha_battle_won 100;
    character_hp_test "Larry HP - Alpha Battle Lost" alpha_battle_lost
      100;
    enemy_hp_test "Dinoplant HP - Alpha Battle" alpha_battle 100;
    enemy_hp_test "Dinoplant HP - Alpha Battle Won" alpha_battle_won 100;
    enemy_hp_test "Dinoplant HP - Alpha Battle Lose" alpha_battle_lost
      100;
    character_test "Larry Character - Alpha Battle" alpha_battle larry;
    character_test "Larry Character - Alpha Battle Won" alpha_battle_won
      larry;
    character_test "Larry Character - Alpha Battle Lose"
      alpha_battle_lost larry;
    enemy_test "Dinoplant Character - Alpha Battle" alpha_battle
      dinoplant;
    enemy_test "Dinoplant Character - Alpha Battle Won" alpha_battle_won
      dinoplant;
    enemy_test "Dinoplant Character - Alpha Battle Lose"
      alpha_battle_lost dinoplant;
    team_test "Alpha Battle Team" alpha_battle [ larry ];
    team_test "Alpha Battle Won Team" alpha_battle_won [ larry ];
    team_test "Alpha Battle Lost Team" alpha_battle [ larry ];
    overbool_test "Alpha Battle Ongoing - Ongoing" alpha_battle false;
    overbool_test "Alpha Battle Won - Ongoing" alpha_battle_won true;
    overbool_test "Alpha Battle Lost - Ongoing" alpha_battle_lost true;
    wonbool_test "Alpha Battle Won - Won" alpha_battle_won true;
    wonbool_test "Alpha Battle Ongoing - Won" alpha_battle false;
    wonbool_test "Alpha Battle Lose - Won" alpha_battle_lost false;
    losebool_test "Alpha Battle Lose - Lose" alpha_battle_lost true;
    losebool_test "Alpha Battle Ongoing - Lose" alpha_battle false;
    losebool_test "Alpha Battle Won - Lose" alpha_battle_won false;
    enemy_hp_test "Dino HP - Larry Thunderbolt - Alpha Battle"
      alpha_battle_larryturn 80;
    character_hp_test "Larry HP - Larry Thunderbolt - Alpha Battle"
      alpha_battle_larryturn 100;
    enemy_hp_test "Dino HP - Dino Thunderbolt - Alpha Battle"
      alpha_battle_dinoturn 80;
    character_hp_test "Larry HP - Dino Thunderbolt - Alpha Battle"
      alpha_battle_dinoturn 90;
  ]

let empty_hatchery = Hatchery.new_hatchery ()
let alpha_hatchery = Hatchery.add_char_to_pool empty_hatchery larry
let beta_hatchery = Hatchery.add_char_to_pool alpha_hatchery dinoplant
let gamma_hatchery = Hatchery.add_char_to_pool beta_hatchery healer

let hatchery_tests =
  [
    get_normalcharpool_test "Empty Hatchery - Normal Char Pool"
      empty_hatchery [];
    get_rarecharpool_test "Empty Hatchery - Rare Char Pool"
      empty_hatchery [];
    get_ssrcharpool_test "Empty Hatchery - SSR Char Pool" empty_hatchery
      [];
    get_normalcharpool_test "Larry Hatchery - Normal Char Pool"
      alpha_hatchery [];
    get_rarecharpool_test "Larry Hatchery - Rare Char Pool"
      alpha_hatchery [ larry ];
    get_ssrcharpool_test "Larry Hatchery - SSR Char Pool" alpha_hatchery
      [];
    get_normalcharpool_test "Larry/Dino Hatchery - Normal" beta_hatchery
      [ dinoplant ];
    get_rarecharpool_test "Larry/Dino Hatchery - Rare" beta_hatchery
      [ larry ];
    get_ssrcharpool_test "Larry/Dino Hatchery - SSR" beta_hatchery [];
    get_normalcharpool_test "Gamma Hatchery - Normal" gamma_hatchery
      [ healer; dinoplant ];
    get_rarecharpool_test "Gamma Hatchery - Rare" gamma_hatchery
      [ larry ];
    get_ssrcharpool_test "Gamma Hatchery - SSR" gamma_hatchery [];
  ]

let level_tests =
  [
    get_map_test "Basiclevel map id" basiclevel "basiclevel";
    get_map_test "level2 map id" level2 "level2";
    start_location_test "Basiclevel start location" basiclevel (48, 48);
    start_location_test "level2 start location" level2
      ((8 * tile_size) + 48, (5 * tile_size) + 48);
    get_tile_test "Basiclevel water tile at 0, 3" basiclevel 2 0 Water;
    get_tile_test "Level2 exit tile at 13, 5" level2 12 4 Exit;
    next_level_test "Basiclevel next level" basiclevel level2;
    next_level_test "Level2 next level" level2 basiclevel;
  ]

let alpha_state = State.init_state basiclevel larry
let level_alpha_state = State.to_level alpha_state
let battle_alpha_state = State.to_battle alpha_state
let hatchery_alpha_state = State.to_hatchery alpha_state

let state_tests =
  [
    current_health_test "Alpha State - Larry HP" alpha_state 100;
    current_health_test "Battle Alpha - Larry HP" battle_alpha_state 100;
    current_health_test "Hatchery Alpha - Larry HP" hatchery_alpha_state
      100;
    current_tile_id_test "Alpha State - Default Location" alpha_state
      (48, 48);
    current_level_test "Alpha State - Basic Level" alpha_state
      basiclevel;
    current_team_test "Alpha State - Default Team" alpha_state [ larry ];
    current_character_pool_test "Alpha State - Default Pool" alpha_state
      [ larry ];
    status_test "Alpha State - Start" alpha_state Start;
    status_test "Alpha State - Level" level_alpha_state Level;
    status_test "Alpha State - Battle" battle_alpha_state Battle;
    status_test "Alpha State - Hatchery" hatchery_alpha_state Hatchery;
  ]

let suite =
  "test suite"
  >::: List.flatten
         ([ character_tests ] @ [ battle_tests ] @ [ hatchery_tests ]
        @ [ state_tests ] @ [ level_tests ])

let _ = run_test_tt_main suite
