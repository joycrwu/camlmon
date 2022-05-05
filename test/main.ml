open OUnit2
open Game
open Battle
open Character

let larry = Yojson.Basic.from_file "data/char/larry.json" |> from_json

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

let character_tests =
  [
    get_id_test "Larry's Name" larry "Larry";
    get_hp_test "Larry's Hp" larry 100;
    get_atk_test "Larry's attack" larry 10;
    get_affinity_test "Larry's attack" larry "Cascadilla Hall";
    (* char_list_test "Character List" [ "larry.json"; "dinoplant.json";
       "healer.json" ]; *)
    get_action_test "Larry's Thunderbolt" larry 0 "Thunderbolt";
    get_action_test "Larry's Fireball" larry 1 "Fireball";
    get_action_test "Larry's Ice Chain" larry 2 "Ice Chain";
    get_action_effect_test "Larry Thunderbolt - 2" larry 0 2;
    get_action_effect_test "Larry Fireball - 3" larry 1 3;
    get_action_effect_test "Larry Ice Chain - 1" larry 1 1;
  ]

let suite = "test suite" >::: List.flatten [ character_tests ]
let _ = run_test_tt_main suite
