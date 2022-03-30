open Character
open Graphics

exception Invalid_input

type map_command =
  | Up
  | Down
  | Left
  | Right
  | Exit
  | Invalid_input

let map_input =
  let k = Graphics.read_key () in
  match k with
  | 'w' -> Up
  | 's' -> Down
  | 'a' -> Left
  | 'd' -> Right
  | 'q' -> Exit
  | _ -> Invalid_input

type battle_command =
  | Attack of int
  | Run
  | Exit
  | Invalid_input

let battle_input (bat : Battle.t) (character : Character.t) =
  let k = Graphics.read_key () in
  match k with
  | '1' -> Attack (Character.get_action_effect character 0)
  | '2' -> Attack (Character.get_action_effect character 1)
  | '3' -> Attack (Character.get_action_effect character 2)
  | 'r' -> Run
  | 'q' -> Exit
  | _ -> Invalid_input