open OUnit2
open Game
open Battle
open Character
open Hatchery

let larry = Yojson.Basic.from_file "data/char/larry.json" |> from_json

let dinoplant =
  Yojson.Basic.from_file "data/char/dinoplant.json" |> from_json

let healer = Yojson.Basic.from_file "data/char/healer.json" |> from_json

(* let (basiclevel : Level.t) = Yojson.Basic.from_file
   "data/level/basiclevel.json" |> Level.from_json *)

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
  name >:: fun _ -> assert_equal expected_output (character_hp battle)

let enemy_hp_test
    (name : string)
    (battle : Battle.t)
    (expected_output : int) =
  name >:: fun _ -> assert_equal expected_output (enemy_hp battle)

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

let get_map_test
    (name : string)
    (lvl : Level.t)
    (expected_output : string) : test =
  name >:: fun _ -> assert_equal expected_output (Level.get_map lvl)

let character_tests =
  [
    get_id_test "Larry's Name" larry "Larry";
    get_id_test "Dinoplant's Name" dinoplant "Dinoplant";
    get_hp_test "Larry's Hp" larry 100;
    get_hp_test "Dinoplant's Hp" dinoplant 100;
    get_atk_test "Larry's attack" larry 10;
    get_atk_test "Dinoplant's attack" dinoplant 5;
    get_affinity_test "Larry's attack" larry "Cascadilla Hall";
    get_affinity_test "Dinoplant's attack" dinoplant "Grass";
    (* char_list_test "Character List" [ "larry.json"; "dinoplant.json";
       "healer.json" ]; *)
    aff_effect_test "Larry aff effect" larry dinoplant 2;
    aff_effect_test "Dinoplant aff effect" dinoplant larry (1 / 2);
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
let alpha_battle_larryturn = character_turn 2 alpha_battle
let alpha_battle_dinoturn = enemy_turn 0 alpha_battle_larryturn

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
      alpha_battle_larryturn 100;
    character_hp_test "Larry HP - Larry Thunderbolt - Alpha Battle"
      alpha_battle_larryturn 100;
    enemy_hp_test "Dino HP - Dino Thunderbolt - Alpha Battle"
      alpha_battle_dinoturn 100;
    character_hp_test "Larry HP - Dino Thunderbolt - Alpha Battle"
      alpha_battle_dinoturn 100;
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
(* let level_tests = [ get_map_test "Basiclevel map" basiclevel
   "basiclevel" ] *)

let suite =
  "test suite"
  >::: List.flatten
         ([ character_tests ] @ [ battle_tests ] @ [ hatchery_tests ])

let _ = run_test_tt_main suite
