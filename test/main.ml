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

let tests = [ get_id_test "Larry's Name" larry "Larry" ]
let suite = "test suite" >::: List.flatten [ tests ]
let _ = run_test_tt_main suite
