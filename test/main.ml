open OUnit2
open Game
open Battle
open Character

let larry = Yojson.Basic.from_file "data/larry.json" |> from_json

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

let tests =
  [
    get_id_test "Larry's Name" larry "Larry";
    get_hp_test "Larry's Hp" larry 100;
    get_atk_test "Larry's attack" larry 50;
    get_affinity_test "Larry's attack" larry "Cascadilla Hall";
  ]

let suite = "test suite" >::: List.flatten [ tests ]
let _ = run_test_tt_main suite
