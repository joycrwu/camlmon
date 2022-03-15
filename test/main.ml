open OUnit2
open Game

let tests = []
let suite = "test suite" >::: List.flatten [ tests ]
let _ = run_test_tt_main suite
